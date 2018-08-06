//
//  IdResponse.swift
//  Movie
//
//  Created by Da on 8/3/18.
//  Copyright © 2018 Tran Cuong. All rights reserved.
//

import Foundation
import ObjectMapper

class KeyTrailerResponse: Mappable {
    var id = 0
    var keyTrailers: [KeyTrailer]?
    
    required init(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        keyTrailers <- map["results"]
    }
}
