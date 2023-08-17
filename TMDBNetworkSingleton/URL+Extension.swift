//
//  URL+Extension.swift
//  TMDBNetworkSingleton
//
//  Created by Heedon on 2023/08/11.
//

import Foundation

extension URL {
    
    //동일한 url 부분
    static let baseURL = "https://api.themoviedb.org/3/"
    
    static let imageURl = "https://image.tmdb.org/t/p/"
    
    
    //URL용 string 만들기
    static func makeEndPointString(_ endPoint: String) -> String {
        return baseURL + endPoint
    }
    
    static func makeImageEndPointString(_ endPoint: String) -> String {
        return imageURl + endPoint
    }
    
}
