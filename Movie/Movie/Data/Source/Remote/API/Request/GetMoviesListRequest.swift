//
//  GetMoviesList.swift
//  Movie
//
//  Created by Da on 7/31/18.
//  Copyright © 2018 Tran Cuong. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire

class GetMoviesListRequest: BaseRequest {
    required init(id: Int) {
        let body: [String: Any]  = [
            "api_key": APIKey.key,
            "language": "en-US"
        ]
        let url = URLs.apiGetMovies + "\(id)" + "/movies"
        super.init(url: url, requestType: .get, body: body)
    }
}
