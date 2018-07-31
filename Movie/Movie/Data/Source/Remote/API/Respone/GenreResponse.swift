//
//  GenreResponse.swift
//  Movie
//
//  Created by Da on 7/31/18.
//  Copyright © 2018 Tran Cuong. All rights reserved.
//

import Foundation
import ObjectMapper

class GenreResponse : Mappable {
    
    var genres = [Genre]()
    
    required init(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        genres <- map["genres"]
    }
}
