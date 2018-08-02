import Foundation
import ObjectMapper

class Movie: BaseModel {
    var id: Int?
    var title: String?
    var posterPath: String?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["original_title"]
        posterPath <- map["poster_path"]
    }
}
