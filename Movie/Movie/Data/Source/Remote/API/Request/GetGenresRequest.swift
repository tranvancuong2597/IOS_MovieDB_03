//
//  GetGenresRequest.swift
//  Movie
//
//  Created by Da on 7/31/18.
//  Copyright © 2018 Tran Cuong. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire

class GetGenresRequest: BaseRequest {
    required init() {
        let body: [String: Any]  = [
            "api_key": APIKey.key,
            "language": "en-US"
        ]
        super.init(url: URLs.apiGetGenres, requestType: .get, body: body)
    }
}
