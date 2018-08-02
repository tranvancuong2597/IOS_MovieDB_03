//
//  CreditRequest.swift
//  Movie
//
//  Created by Da on 8/3/18.
//  Copyright © 2018 Tran Cuong. All rights reserved.
//
import Foundation
import ObjectMapper
import Alamofire

class CreditRequest: BaseRequest {
    required init(id: Int) {
        let body: [String: Any]  = [
            "api_key": APIKey.key,
            "language": "en-US"
        ]
        let url = URLs.apiGetId + "\(id)" + "/credits"
        super.init(url: url, requestType: .get, body: body)
    }
}
