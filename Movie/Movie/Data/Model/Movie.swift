import Foundation
import ObjectMapper

class Movie: BaseModel {
    var id: Int?
    var title: String?
    var posterPath: String?
    var vote: Int?
    var overview: String?
    var releaseDate: String?
    var popularity: Int?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["original_title"]
        posterPath <- map["poster_path"]
        vote <- map["vote_average"]
        overview <- map["overview"]
        releaseDate <- map["release_date"]
        popularity <- map["popularity"]
    }
}
