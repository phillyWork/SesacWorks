//
//  EndPoint.swift
//  TMDBSegmentControlDispatchGroup
//
//  Created by Heedon on 2023/08/18.
//

import Foundation

enum EndPoint {
    case movie
    case video
    
    var requestedUrl: String {
        switch self {
        case .movie:
            return "/similar?language=ko-KR&page="
        case .video:
            return "/videos?language=ko-KR"
        }
    }
}
