//
//  Extension.swift
//  TMDBCodeBaseNetworkSingleton
//
//  Created by Heedon on 2023/08/28.
//

import UIKit

//MARK: - URL

extension URL {
    
    //동일한 url 부분
    static let baseURL = "https://api.themoviedb.org/3/"
    static let imageURL = "https://image.tmdb.org/t/p/"
    static let youtubeURL = "https://www.youtube.com/watch?v="
        
    //URL용 string 만들기
    static func makeDataURLString(_ endPoint: String) -> String {
        return baseURL + endPoint
    }
    
    static func makeImageURLString(_ endPoint: String) -> String {
        return imageURL + endPoint
    }
    
    static func makeYoutubeURLString(_ endPoint: String) -> String {
        return youtubeURL + endPoint
    }

}
