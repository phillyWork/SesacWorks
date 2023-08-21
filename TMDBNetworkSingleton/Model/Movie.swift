//
//  Content.swift
//  TMDBNetworkSingleton
//
//  Created by Heedon on 2023/08/11.
//

import Foundation

struct MovieJSON {
    let title: String
    let movieId: Int
    let overview: String
    let backdropPath: String
    let posterPath: String
    let rate: Double
    let genreIds: [Int]
    let releaseDate: String
    
}
