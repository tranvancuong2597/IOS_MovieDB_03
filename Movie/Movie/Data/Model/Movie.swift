import Foundation
import ObjectMapper

class Movie: BaseModel {
    var id: Int?
    var original_title: String?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        original_title <- map["original_title"]
    }
}
