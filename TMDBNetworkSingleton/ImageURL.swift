//
//  ImageURL.swift
//  TMDBNetworkSingleton
//
//  Created by Heedon on 2023/08/12.
//

import Foundation

enum ImageURL {
    
    case backPath
    case poster
    case profile
    
    var requestURL: String {
        switch self {
        case .backPath:
            return URL.makeImageEndPointString("original")     //뒷배경 사진: 원본
        case .poster:
            return URL.makeImageEndPointString("w342")         //포스터 사진: width 342
        case .profile:
            return URL.makeImageEndPointString("w45")          //프로필 사진: width 45
        }
    }
    
}
