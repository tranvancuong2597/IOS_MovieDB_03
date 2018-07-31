//
//  UserRepository.swift
//  Movie
//
//  Created by Da on 7/31/18.
//  Copyright © 2018 Tran Cuong. All rights reserved.
//

import Foundation
import ObjectMapper

protocol UserRepository {
    func getGenres(completion: @escaping (BaseResult<GenreResponse>) -> Void)
}

class UserRepositoryImpl: UserRepository {
    
    private var api: APIService?
    required init(api: APIService) {
        self.api = api
    }
    
    func getGenres(completion: @escaping (BaseResult<GenreResponse>) -> Void) {
        let input = GetGenresRequest()
        api?.request(input: input) { (object: GenreResponse?, error) in
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
