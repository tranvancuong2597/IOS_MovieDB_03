//
//  SearchMoviesResponse.swift
//  Movie
//
//  Created by TranCuong on 8/4/18.
//  Copyright © 2018 Tran Cuong. All rights reserved.
//

import Foundation
import ObjectMapper

class SearchMoviesResponse : Mappable {
    var page: Int?
    var totalPages: Int?
    var movies = [Movie]()
    
    required init(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        movies <- map["results"]
        page <- map["page"]
        totalPages <- map["total_pages"]
    }
}
