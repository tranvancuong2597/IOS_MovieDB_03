//
//  ErrorResponse.swift
//  Movie
//
//  Created by Da on 7/31/18.
//  Copyright © 2018 Tran Cuong. All rights reserved.
//

import Foundation
import Foundation
import ObjectMapper
class ErrorResponse: Mappable {
    
    var message: String?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        message <- map["status_message"]
    }
}
