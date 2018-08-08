import Foundation
import ObjectMapper

class Movie: BaseModel {
    var id = 0
    var title = ""
    var posterPath = ""
    var vote: Double = 0.00
    var overview = ""
    var releaseDate = ""
    var popularity = 0
    
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
    
    init(movieId: Int, title: String, posterPath: String, overview: String) {
        self.id = movieId
        self.title = title
        self.posterPath = posterPath
        self.overview = overview
    }
}
