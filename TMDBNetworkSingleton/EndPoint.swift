//
//  EndPoint.swift
//  TMDBNetworkSingleton
//
//  Created by Heedon on 2023/08/11.
//

import Foundation

//API마다 다른 url 관리

enum EndPoint {
    
    //API 활용 case 구분
    case trendMovie
    case movieCasting
    
    //해당 url 만들기
    var requestURL: String {
        switch self {
        case .trendMovie:
            return URL.makeEndPointString("trending/movie/")
        case .movieCasting:
            return URL.makeEndPointString("movie/")
        }
    }
    
}

