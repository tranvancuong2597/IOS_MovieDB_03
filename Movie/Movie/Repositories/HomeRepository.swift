//
//  UserRepository.swift
//  Movie
//
//  Created by Da on 7/31/18.
//  Copyright © 2018 Tran Cuong. All rights reserved.
//

import Foundation
import ObjectMapper

protocol HomeRepository {
    func getGenres(completion: @escaping (BaseResult<GenreResponse>) -> Void)
    func getMoviesList(id: Int, completion: @escaping (BaseResult<MoviesListResponse>) -> Void)
}

class HomeRepositoryImpl: HomeRepository {
    private var api: APIService?
    
    required init(api: APIService) {
        self.api = api
    }
    
    static let sharedInstance: HomeRepository = HomeRepositoryImpl(api: APIService.share)
    
    func getGenres(completion: @escaping (BaseResult<GenreResponse>) -> Void) {
        let input = GetGenresRequest()
        api?.request(input: input) { (object: GenreResponse?, error) in
            if let error = error {
                completion(.failure(error: error))}
            else if let object = object {
                completion(.success(object))
            }
            else {
                completion(.failure(error: nil))
            }
        }
    }
    
    func getMoviesList(id: Int, completion: @escaping (BaseResult<MoviesListResponse>) -> Void) {
        let input = GetMoviesListRequest(id: id)
        api?.request(input: input) { (object: MoviesListResponse?, error) in
            if let error = error {
                completion(.failure(error: error))}
            else if let object = object {
                completion(.success(object))
            }
            else {
                completion(.failure(error: nil))
            }
        }
    }
}
