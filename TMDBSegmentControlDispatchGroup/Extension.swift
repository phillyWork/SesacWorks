//
//  Extension.swift
//  TMDBSegmentControlDispatchGroup
//
//  Created by Heedon on 2023/08/18.
//

import UIKit

//MARK: - UICollectionViewCell
extension UICollectionViewCell: ReusableViewProtocol {
    
    static var identifier: String {
        return String(describing: self)
    }

}

//MARK: - URL
extension URL {
    
    static let baseURL = "https://api.themoviedb.org/3/movie/"
    static let imageBaseURL = "https://image.tmdb.org/t/p/"
    static let youtubeBaseURL = "https://www.youtube.com/watch?v="
    
    static func makeEndPoint(_ endPoint: String) -> String {
        return baseURL + endPoint
    }
    
    static func makeEndPointYoutubeURL(_ endPoint: String) -> String {
        return youtubeBaseURL + endPoint
    }
    
    static func makeEndPointImageURL(_ endPoint: String) -> String {
        return imageBaseURL + endPoint
    }
    
}
