//
//  SimilarMovieList.swift
//  TMDBCodeBaseNetworkSingleton
//
//  Created by Heedon on 2023/08/28.
//

import Foundation

struct SimilarList: Codable {
    let page: Int
    let list: [Similar]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page
        case list = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Similar: Codable {
    let adult: Bool
    let backdropPath: String?
    let genreIDS: [Int]
    let id: Int
    let originalLanguage: String
    let originalTitle: String?
    let originalName: String?
    let overview: String
    let popularity: Double
    let posterPath: String?
    let releaseDate, title, name: String?
    let firstAirDate: String?
    let video: Bool?
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case originalName = "original_name"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case firstAirDate = "first_air_date"
        case title, video, name
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    var cellTitle: String {
        if let name = name, let originalName = originalName {
            return name + "(\(originalName)"
        } else {
            return title! + "(\(originalTitle))"
        }
        
    }
    
    var dateRate: String {
        let rate = round(voteAverage*100)/100
        
        if let firstAirDate = firstAirDate {
            return firstAirDate + " | \(rate)"
        } else {
            return releaseDate! + " | \(rate)"
        }
    }
    
}
