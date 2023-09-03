//
//  DataUrl.swift
//  TMDBCodeBaseNetworkSingleton
//
//  Created by Heedon on 2023/08/28.
//

import Foundation

enum DataUrl {
    
    //API case 구분
    case trendAll
    case trendMovie
    case movieCasting
    case trendTV
    case tvCasting
    case seasonDetail
    case episodeDetail
    case similarMovie
    case similarTV
    case videoMovie
    case videoTV
    
    var requestURL: String {
        switch self {
        case .trendAll:
            return URL.makeDataURLString("trending/all/day")
        case .trendMovie:
            return URL.makeDataURLString("trending/movie/day")
        case .movieCasting:
            return URL.makeDataURLString("movie/")
        case .trendTV:
            return URL.makeDataURLString("trending/tv/day")
        case .tvCasting:
            return URL.makeDataURLString("tv/")
        case .seasonDetail:
            return URL.makeDataURLString("tv/")
        case .episodeDetail:
            return URL.makeDataURLString("tv/")
        case .similarMovie:
            return "/similar?language=ko-KR&page="
        case .similarTV:
            return "/similar?language=ko-KR&page="
        case .videoMovie:
            return "/videos?language=ko-KR"
        case .videoTV:
            return "/videos?language=ko-KR"
            
        }
    }
    
}
