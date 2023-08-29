//
//  ImageUrl.swift
//  TMDBCodeBaseNetworkSingleton
//
//  Created by Heedon on 2023/08/28.
//

import Foundation

enum ImageUrl {
    
    case stillPath
    case posterPath
    case backPath
    case profilePath
    
    var requestURL: String {
        switch self {
        case .stillPath, .backPath:
            return URL.makeImageURLString("original/")
        case .posterPath:
            return URL.makeImageURLString("w342/")
        case .profilePath:
            return URL.makeImageURLString("w45/")
        }
    }
    
}
