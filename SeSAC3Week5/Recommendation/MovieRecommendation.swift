//
//  MovieRecommendation.swift
//  SeSAC3Week5
//
//  Created by Heedon on 2023/08/17.
//

import Foundation

// MARK: - MovieRecommendation
struct MovieRecommendation: Codable {
    let page, totalPages: Int
    let results: [Movie]
    let totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case results
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Movie: Codable {
    let genreIDS: [Int]
    let id: Int
    let overview: String
    let voteAverage: Double
    let originalTitle: String
    let posterPath, backdropPath: String?
    let originalLanguage: String    //OriginalLanguage
    let mediaType: MediaType
    let voteCount: Int
    let popularity: Double
    let adult: Bool
    let releaseDate, title: String
    let video: Bool

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id, overview
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case mediaType = "media_type"
        case voteCount = "vote_count"
        case popularity, adult
        case releaseDate = "release_date"
        case title, video
    }
}

enum MediaType: String, Codable {
    case movie = "movie"
}

//enum OriginalLanguage: String, Codable {
//    case en = "en"
//    case fr = "fr"
//    case it = "it"
//    case ko = "ko"
//}
