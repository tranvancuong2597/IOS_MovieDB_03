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
    public static let APIGetGenresUrl = APIBaseUrl + "/genre/movie/list"
    public static let APISearchUserUrl = APIBaseUrl + "/search/company"
    public static let APIGetMoviesByGenres = APIBaseUrl + "/list/"
}
