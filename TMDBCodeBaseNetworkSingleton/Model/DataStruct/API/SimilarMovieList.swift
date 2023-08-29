//
//  SimilarMovieList.swift
//  TMDBCodeBaseNetworkSingleton
//
//  Created by Heedon on 2023/08/28.
//

import Foundation

struct SimilarMovieList: Codable {
    let page: Int
    let movieList: [SimilarMovie]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page
        case movieList = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct SimilarMovie: Codable {
    let adult: Bool
    let backdropPath: String?
    let genreIDS: [Int]
    let id: Int
    let originalLanguage, originalTitle, overview: String
    let popularity: Double
    let posterPath: String?
    let releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    var cellTitle: String {
        return title + "(\(originalTitle))"
    }
    
    var dateRate: String {
        let rate = round(voteAverage*100)/100
        return releaseDate + " | \(rate)"
    }
    
}
