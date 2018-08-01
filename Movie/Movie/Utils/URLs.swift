//
//  URLs.swift
//  Movie
//
//  Created by Da on 7/31/18.
//  Copyright © 2018 Tran Cuong. All rights reserved.
//

import Foundation

struct URLs {
    private static var APIBaseUrl = "https://api.themoviedb.org/3"
    
    public static let APIGetGenres = APIBaseUrl + "/genre/movie/list"
    
    public static let APISearchUser = APIBaseUrl + "/search/company"
    
    public static let APIGetMoviesList = APIBaseUrl + "/genre/"
    
    public static let Poster_image = "https://image.tmdb.org/t/p/w300_and_h450_bestv2"
}
