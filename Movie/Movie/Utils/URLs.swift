//
//  URLs.swift
//  Movie
//
//  Created by Da on 7/31/18.
//  Copyright © 2018 Tran Cuong. All rights reserved.
//

import Foundation

struct URLs {
    private static var apiBaseUrl = "https://api.themoviedb.org/3"
    
    public static let apiGetGenres = apiBaseUrl + "/genre/movie/list"
    
    public static let apiSearchUser = apiBaseUrl + "/search/company"
    
    public static let apiGetMovies = apiBaseUrl + "/genre/"
    
    public static let posterImage = "https://image.tmdb.org/t/p/w300_and_h450_bestv2"
}
