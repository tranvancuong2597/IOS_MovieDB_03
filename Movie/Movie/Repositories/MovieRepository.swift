//
//  MovieRepository.swift
//  Movie
//
//  Created by Da on 7/31/18.
//  Copyright © 2018 Tran Cuong. All rights reserved.
//
import Foundation
import ObjectMapper


typealias completionMovies = (BaseResult<MoviesListResponse>) -> Void
typealias completionTopMovies = (BaseResult<MoviesTopListResponse>) -> Void
typealias completionPopularMovies = (BaseResult<MoviesPopularListResponse>) -> Void
typealias completionUpcomingMovies = (BaseResult<MoviesUpcomingListResponse>) -> Void
typealias completionSearchMovies = (BaseResult<SearchMoviesResponse>) -> Void

protocol MovieRepository {
    func getMoviesList(id: Int, completion: @escaping completionMovies)
    
    func getTopMoviesList(completion: @escaping completionTopMovies)
    
    func getPopularMoviesList(completion: @escaping completionPopularMovies)
    
    func getUpcomingMoviesList(completion: @escaping completionUpcomingMovies)
    
    func getKeyTrailer(id: Int, completion: @escaping completionIdTrailler)
    
    func getCredit(id: Int, completion: @escaping completionCredit)
    
    func getSearchMoviesList(query: String, page: Int,completion: @escaping completionSearchMovies)
}

typealias completionIdTrailler = (BaseResult<KeyTrailerResponse>) -> Void
typealias completionCredit = (BaseResult<CreditResponse>) -> Void

class MovieRepositoryImpl: MovieRepository {
    
    private var api: APIService?
    required init(api: APIService) {
        self.api = api
    }
    
    static let sharedInstance: MovieRepository = MovieRepositoryImpl(api: APIService.share)
    
    func getMoviesList(id: Int, completion: @escaping completionMovies) {
        let input = GetMoviesRequest(id: id)
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
    
    func getKeyTrailer(id: Int, completion: @escaping completionIdTrailler) {
        let input = KeyTrailerRequest(id: id)
        guard let api = api else {
            return
        }
        api.request(input: input) { (object: KeyTrailerResponse?, error) in
            guard let object = object else {
                guard let error = error else {
                    return completion(.failure(error: nil))
                }
                return completion(.failure(error: error))
            }
            completion(.success(object))
        }
    }
    
    func getCredit(id: Int, completion: @escaping completionCredit) {
        let input = CreditRequest(id: id)
        guard let api = api else {
            return
        }
        api.request(input: input) { (object: CreditResponse?, error) in
            guard let object = object else {
                guard let error = error else {
                    return completion(.failure(error: nil))
                }
                return completion(.failure(error: error))
            }
            completion(.success(object))
        }
    }
    
    func getTopMoviesList(completion: @escaping completionTopMovies) {
        let input = GetMoviesTopListRequest()
        api?.request(input: input) { (object: MoviesTopListResponse?, error) in
            if let object = object {
                completion(.success(object))
            } else if let error = error {
                completion(.failure(error: error))
            } else {
                completion(.failure(error: nil))
            }
        }
    }
    
    func getPopularMoviesList(completion: @escaping completionPopularMovies) {
        let input = GetMoviesPopularListRequest()
        api?.request(input: input) { (object: MoviesPopularListResponse?, error) in
            if let object = object {
                completion(.success(object))
            } else if let error = error {
                completion(.failure(error: error))
            } else {
                completion(.failure(error: nil))
            }
        }
    }
    
    func getUpcomingMoviesList(completion: @escaping completionUpcomingMovies) {
        let input = GetMoviesUpcomingListRequest()
        api?.request(input: input) { (object: MoviesUpcomingListResponse?, error) in
            if let object = object {
                completion(.success(object))
            } else if let error = error {
                completion(.failure(error: error))
            } else {
                completion(.failure(error: nil))
            }
        }
    }
    
    func getSearchMoviesList(query: String, page: Int, completion: @escaping completionSearchMovies) {
        let input = GetSearchListRequest(query: query, page: page)
        api?.request(input: input) { (object: SearchMoviesResponse?, error) in
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
