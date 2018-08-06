//
//  CreditResponse.swift
//  Movie
//
//  Created by Da on 8/3/18.
//  Copyright © 2018 Tran Cuong. All rights reserved.
//

import Foundation
import ObjectMapper

class CreditResponse: Mappable {
    var id = 0
    var casts = [Credit]()
    var crews = [Credit]()
    
    required init(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        casts <- map["cast"]
        crews <- map["crew"]
    }
}
