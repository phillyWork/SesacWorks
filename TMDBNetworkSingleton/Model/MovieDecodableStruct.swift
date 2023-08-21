//
//  MovieDecodableStruct.swift
//  TMDBNetworkSingleton
//
//  Created by Heedon on 2023/08/14.
//

import Foundation

// MARK: - MovieTrend
struct MovieTrend: Codable {
    let page: Int
    let movieList: [Movie]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page
        case movieList =  "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Movie: Codable {
    let adult: Bool
    let backdropPath: String
    let id: Int
    let title: String
    let originalLanguage: String
    let originalTitle, overview, posterPath: String
    let mediaType: String
    let genreIDS: [Int]
    let popularity: Double
    let releaseDate: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id, title
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case genreIDS = "genre_ids"
        case popularity
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

//enum MediaType: String, Codable {
//    case movie = "movie"
//}

//enum OriginalLanguage: String, Codable {
//    case en = "en"
//    case hi = "hi"
//    case yo = "yo"
//    case zh = "zh"
//}
