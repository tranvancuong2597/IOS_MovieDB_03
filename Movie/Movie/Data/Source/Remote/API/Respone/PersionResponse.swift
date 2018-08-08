//
//  PersionResponse.swift
//  Movie
//
//  Created by Da on 8/6/18.
//  Copyright © 2018 Tran Cuong. All rights reserved.
//

import Foundation
import ObjectMapper

class PersionResponse: Mappable {
    var birthday = ""
    var knownForDepartment = ""
    var biography = ""
    var placeOfBirth = ""
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        birthday <- map["birthday"]
        knownForDepartment <- map["known_for_department"]
        biography <- map["biography"]
        placeOfBirth <- map["place_of_birth"]
    }
}
