//
//  CreditRepository.swift
//  Movie
//
//  Created by Da on 8/6/18.
//  Copyright © 2018 Tran Cuong. All rights reserved.
//

import Foundation
import ObjectMapper

protocol CreditDetailRepository {
    func getMovies(id: Int?, completion: @escaping completionMoviesByCredit)
    func getDetailPerson(id: Int?, completion: @escaping completionPerson)
}

typealias completionMoviesByCredit = (BaseResult<MoviesByCreditResponse>) -> Void
typealias completionPerson = (BaseResult<PersionResponse>) -> Void

class CreditDetailRepositoryImpl: CreditDetailRepository {
   private let api: APIService?
    
    required init(api: APIService) {
        self.api = api
    }
    
    static let sharedInstance: CreditDetailRepository = CreditDetailRepositoryImpl(api: APIService.share)
    
    func getMovies(id: Int?, completion: @escaping completionMoviesByCredit) {
        guard let id = id, let api = api else {
                return
        }
        let input = GetMoviesByCreditRequest(id: id)
        api.request(input: input) { (object: MoviesByCreditResponse?, error) in
            guard let object = object else {
                guard let error = error else {
                    return completion(.failure(error: nil))
                }
                return completion(.failure(error: error))
            }
            completion(.success(object))
        }
    }
    
    func getDetailPerson(id: Int?, completion: @escaping completionPerson) {
        guard let id = id, let api = api else {
                return
        }
        let input = GetDetailPersonRequest(id: id)
        api.request(input: input) { (object: PersionResponse?, error) in
            guard let object = object else {
                guard let error = error else {
                    return completion(.failure(error: nil))
                }
                return completion(.failure(error: error))
            }
            completion(.success(object))
        }
    }
}
