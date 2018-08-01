//
//  MovieRepository.swift
//  Movie
//
//  Created by Da on 7/31/18.
//  Copyright © 2018 Tran Cuong. All rights reserved.
//


import Foundation
import ObjectMapper

protocol MovieRepository {
    func getMoviesList(id: Int, completion: @escaping (BaseResult<MoviesListResponse>) -> Void)
}

class MovieRepositoryImpl: MovieRepository {
    private var api: APIService?
    required init(api: APIService) {
        self.api = api
    }
    
    static let sharedInstance: MovieRepository = MovieRepositoryImpl(api: APIService.share)
    
    func getMoviesList(id: Int, completion: @escaping (BaseResult<MoviesListResponse>) -> Void) {
        let input = GetMoviesListRequest(id: id)
        api?.request(input: input) { (object: MoviesListResponse?, error) in
            if let object = object {
                completion(.success(object))
            } else if let error = error {
                completion(.failure(error: error))
            } else {
                completion(.failure(error: nil))
            }
        }
    }
}
