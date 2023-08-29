//
//  TVStruct.swift
//  TMDBCodeBaseNetworkSingleton
//
//  Created by Heedon on 2023/08/28.
//

import Foundation

// MARK: - TrendTVResult
struct TrendTVResult: Codable {
    let page: Int
    let tvLists: [TVSeries]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page
        case tvLists = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct TVSeries: Codable {
    let adult: Bool
    let backdropPath: String
    let id: Int
    let name, originalLanguage, originalName, overview: String
    let posterPath: String
    let mediaType: String
    let genreIDS: [Int]
    let popularity: Double
    let firstAirDate: String
    let voteAverage: Double
    let voteCount: Int
    let originCountry: [String]

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
    }
}
