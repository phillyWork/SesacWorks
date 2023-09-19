//
//  EndPoint.swift
//  TMDBAPICallTwiceInARow
//
//  Created by Heedon on 2023/08/16.
//

import Foundation

enum EndPoint {
    case trendTV
    case seasonDetail
    case episodeDetail
    
    var requestUrl: String {
        switch self {
        case .trendTV:
            return URL.makeEndPointString("trending/tv/day")
        case .seasonDetail:
            return URL.makeEndPointString("tv/")
        case .episodeDetail:
            return URL.makeEndPointString("tv/")
        }
    }
}
