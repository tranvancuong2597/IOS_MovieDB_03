//
//  MoviesPopularListResponse.swift
//  Movie
//
//  Created by TranCuong on 8/1/18.
//  Copyright © 2018 Tran Cuong. All rights reserved.
//

import Foundation
import ObjectMapper

class MoviesPopularListResponse : Mappable {
    var movies = [Movie]()
    
    required init(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        movies <- map["results"]
    }
}
