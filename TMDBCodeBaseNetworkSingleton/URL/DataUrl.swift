//
//  DataUrl.swift
//  TMDBCodeBaseNetworkSingleton
//
//  Created by Heedon on 2023/08/28.
//

import Foundation

enum DataUrl {
    
    //API case 구분
    case trendMovie
    case movieCasting
    case trendTV
    case seasonDetail
    case episodeDetail
    case similarMovie
    case video
    
    var requestURL: String {
        switch self {
        case .trendMovie:
            return URL.makeDataURLString("trending/movie/day")
        case .movieCasting:
            return URL.makeDataURLString("movie/")
        case .trendTV:
            return URL.makeDataURLString("trending/tv/day")
        case .seasonDetail:
            return URL.makeDataURLString("tv/")
        case .episodeDetail:
            return URL.makeDataURLString("tv/")
        case .similarMovie:
            return "movie/similar?language=ko-KR&page="
        case .video:
            return "movie/videos?language=ko-KR"
        }
    }
    
}
