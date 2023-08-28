//
//  EndPoint.swift
//  NetworkingProj
//
//  Created by Heedon on 2023/08/11.
//

import Foundation

//url도 enum으로 관리

enum EndPoint {
    
    //API 활용 각 case들
    case blog
    case cafe
    case video
    
    //앞쪽 동일한 link 존재 시, URL extension에서 type property로 설정, 함수로 URL용 string 만듬

    //하나의 link로 모아두기
    //query 뒷 부분은 사용자 입력에 따라 달라짐
    var requestUrl: String {
        switch self {
        case .blog:
            return URL.makeEndPointString("blog?query=")
        case .cafe:
            return URL.makeEndPointString("cafe?query=")
        case .video:
            return URL.makeEndPointString("vclip?query=")
        }
    }
    
}
