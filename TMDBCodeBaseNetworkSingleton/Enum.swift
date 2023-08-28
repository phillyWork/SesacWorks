//
//  Enum.swift
//  TMDBCodeBaseNetworkSingleton
//
//  Created by Heedon on 2023/08/28.
//

import Foundation

//MARK: - Movie Genre

enum GenreIds: Int {
    case action = 28
    case adventure = 12
    case animation = 16
    case comedy = 35
    case crime = 80
    case documentary = 99
    case drama = 18
    case family = 10751
    case fantasy = 14
    case history = 36
    case horror = 27
    case music = 10402
    case mystery = 9648
    case romance = 10749
    case sf = 878
    case tvMovie = 10770
    case thriller = 53
    case war = 10752
    case western = 37
    
    var genreName: String {
        return String(describing: self)
    }
}
