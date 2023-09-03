//
//  ImagePath.swift
//  TMDBAPICallTwiceInARow
//
//  Created by Heedon on 2023/08/16.
//

import Foundation

enum ImagePath {
    
    case stillPath
    case posterPath
    
    var requestUrl: String {
        switch self {
        case .stillPath:
            return URL.makeImageEndPointString("original/")
        case .posterPath:
            return URL.makeImageEndPointString("w342/")
        }
    }
    
}
