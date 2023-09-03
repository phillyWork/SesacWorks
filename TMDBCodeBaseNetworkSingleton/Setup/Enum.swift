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
    case actionAdventure = 10759
    case kids = 10762
    case news = 10763
    case reality = 10764
    case sfFantasy = 10765
    case soap = 10766
    case talk = 10767
    case warPolitics = 10768
    
    
    var genreName: String {
        switch self {
        case .actionAdventure:
            return "action&adventure"
        case .sfFantasy:
            return "sf&fantasy"
        case .warPolitics:
            return "war&politics"
        case .tvMovie:
            return "tv movie"
        default:
            return String(describing: self)
        }
    }
}








//MARK: - TrendType

enum TrendData: String {
    case trendAll
    case trendMovie
    case trendTV
}
