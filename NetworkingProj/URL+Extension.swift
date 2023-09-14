//
//  URL+Extension.swift
//  NetworkingProj
//
//  Created by Heedon on 2023/08/11.
//

import Foundation

extension URL {
    
    //url 동일한 부분 존재시
    static let baseURL = "https://dapi.kakao.com/v2/search/"
    
    //URL string 만드는 함수 정의
    static func makeEndPointString(_ endPoint: String) -> String {
        return baseURL + endPoint
    }
    
}
