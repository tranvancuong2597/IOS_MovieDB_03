//
//  GetSearchListRequest.swift
//  Movie
//
//  Created by TranCuong on 8/4/18.
//  Copyright © 2018 Tran Cuong. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire

class GetSearchListRequest: BaseRequest {
    required init(query: String, page: Int) {
        let body: [String: Any]  = [
            "api_key": APIKey.key,
            "language": "en-US",
            "query": query
        ]
        let url = URLs.apiMovieSearch
        super.init(url: url, requestType: .get, body: body)
    }
}
