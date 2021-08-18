//
//  LEServices.swift
//  Leisure
//
//  Created by Mamta Sharma on 8/18/21.
//

import Foundation

struct APIKey {
    static let APIKEY = "0a233df5eafd9c5410b7674932272d55"
}

struct Services {
    static var apiKeyUrl: String {
        return "api_key=\(APIKey.APIKEY)"
    }
    static var getMovie: String {
        return "movie/550"
    }
    static var baseUrl: String {
        return "https://api.themoviedb.org/3/"
    }
    static var imageBaseUrl: String {
        return "https://image.tmdb.org/t/p/w500"
    }
    static var searchMovie: String {
        return "search/movie"
    }
    static var requestToken: String {
        return "authentication/token/new"
    }
    static var validateToken: String {
        return "authentication/token/validate_with_login"
    }
    static var newSession: String {
        return "authentication/session/new"
    }
    static var makeFav: String {
        return "account/%7Baccount_id%7D/favorite"
    }
    static var makeWatch: String {
        return "account/%7Baccount_id%7D/watchlist"
    }
    static var getFav: String {
        return "account/%7Baccount_id%7D/favorite/movies"
    }
    static var getWatch: String {
        return "account/%7Baccount_id%7D/watchlist/movies"
    }
    static var dummyTrailer: String {
        return "https://www.youtube.com/watch?v=AICMLJ13ZwE&ab_channel=MovieclipsTrailers"
    }
}

enum ServiceError: String {
    case invalidResponse = "Something went wrong"
}
