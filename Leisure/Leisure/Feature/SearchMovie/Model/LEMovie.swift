//
//  Movie.swift
//  Leisure
//
//  Created by Mamta Sharma on 8/18/21.
//

import Foundation

struct LESearchMovie: Codable {
    let page: Int?
    let results: [LEMovie]?
    let totalPages: Int?
    let totalResults: Int?
    private enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "totalResults"
    }
}

class LEMovie: Codable {
    let adult: Bool?
    let backdropPath: String?
    let genreIds: [Int]?
    let idValue: Int?
    let originalLanguage: String?
    let originalTitle: String?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    var isfav: Bool = false
    var isWatch: Bool = false

    private enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case idValue = "id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

struct LEFavModel: Codable {
    let success: Bool?
    let statusCode: Int
    let statusMessage: String?
    private enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }
}
