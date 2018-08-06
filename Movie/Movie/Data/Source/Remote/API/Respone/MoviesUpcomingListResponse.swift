//
//  MoviesUpcomingListResponse.swift
//  Movie
//
//  Created by TranCuong on 8/2/18.
//  Copyright © 2018 Tran Cuong. All rights reserved.
//

import Foundation
import ObjectMapper

class MoviesUpcomingListResponse : Mappable {
    var movies = [Movie]()
    
    required init(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        movies <- map["results"]
    }
}
