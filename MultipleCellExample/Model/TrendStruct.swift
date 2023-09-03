//
//  TrendStruct.swift
//  MultipleCellExample
//
//  Created by Heedon on 2023/09/03.
//

import Foundation

// MARK: - TrendingAllList
struct TrendingAllList: Codable {
    let page: Int
    let trendingList: [Trend]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page
        case trendingList = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Trend: Codable {
    let adult: Bool
    let backdropPath: String
    let id: Int
    let name: String?
    let originalLanguage: String
    let originalName: String?
    let overview, posterPath: String
    let mediaType: MediaType
    let genreIDS: [Int]
    let popularity: Double
    let firstAirDate: String?
    let voteAverage: Double
    let voteCount: Int
    let originCountry: [String]?
    let title, originalTitle, releaseDate: String?
    let video: Bool?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id, name
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case genreIDS = "genre_ids"
        case popularity
        case firstAirDate = "first_air_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case originCountry = "origin_country"
        case title
        case originalTitle = "original_title"
        case releaseDate = "release_date"
        case video
    }
    
    var rating: Double {
        return round(self.voteAverage*100)/100
    }
}

enum MediaType: String, Codable {
    case movie = "movie"
    case tv = "tv"
//    case person = "person"
}
