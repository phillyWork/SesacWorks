//
//  URL+Extension.swift
//  TMDBAPICallTwiceInARow
//
//  Created by Heedon on 2023/08/16.
//

import Foundation

extension URL {
    
    static let baseUrl = "https://api.themoviedb.org/3/"
    static let imageBaseUrl = "https://image.tmdb.org/t/p/"
    
    static func makeEndPointString(_ endPoint: String) -> String {
        return baseUrl + endPoint
    }
    
    static func makeImageEndPointString(_ endPoint: String) -> String {
        return imageBaseUrl + endPoint
    }
    
}
