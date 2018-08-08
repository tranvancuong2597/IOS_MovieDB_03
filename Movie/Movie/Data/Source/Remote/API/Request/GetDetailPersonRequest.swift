//
//  GetDetailPerson.swift
//  Movie
//
//  Created by Da on 8/6/18.
//  Copyright © 2018 Tran Cuong. All rights reserved.
//
import Foundation
import ObjectMapper
import Alamofire

class GetDetailPersonRequest: BaseRequest {
    required init(id: Int) {
        let body: [String: Any] = [
            "api_key": APIKey.key,
            "language": "en-US"
        ]
        let url = URLs.apiGetMoviesByCredit + "\(id)"
        super.init(url: url, requestType: .get, body: body)
    }
}
