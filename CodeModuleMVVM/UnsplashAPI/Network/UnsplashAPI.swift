//
//  UnsplashAPI.swift
//  CodeModuleMVVM
//
//  Created by Heedon on 2023/09/19.
//

import Foundation
import Alamofire

//아쉬운점: network에서 활용 --> 연산 property 호출: private 활용 제약
enum UnsplashAPI {
    
    //Key: APIKey에서 관리
        
    //endPoint 명시
    case search(query: String)     //필요할 때마다 query 받기
    case random
    case single(id: String)         //필요한 id 매개변수 (연관값) ~ 같이 받기
    
    //header도 case따라 다를 경우, switch로 다르게 설정 가능
    var headers: HTTPHeaders {
        ["Authorization": "Client-ID \(APIKey.accessKey)"]
    }
    
    //method도 case따라 다를 경우, switch로 다르게 설정 가능
    var method: HTTPMethod {
        return .get
    }
    
    //공통 부분
    //case 따라 다른 부분으로 더 detail하게 나눌 수도 있음
    //private 활용: compile 성능 높임 (다른 파일 영향 주지 않음 알림)
    private var baseURL: String {
        switch self {
        case .search, .random:
            return "https://api.unsplash.com/"
        case .single:
            return "https://api.unsplash.com/"
        }
    }
    
    var endPoint: URL {
        switch self {
        case .search:
            return URL(string: baseURL + "search/photos")!
        case .random:
            return URL(string: baseURL + "photos/random")!
        case .single(let id):
            return URL(string: baseURL + "photos/\(id)")!       //연관값 활용
        }
    }
    
    //Parameter type 활용
    var query: [String: String] {
        switch self {
        case .search(let query):    //연관값 활용/받아온 data 활용
            return ["query": query]
        case .random, .single:      //연관값 사용 안하면 안써도 okay
            return ["": ""]          //내용 없음 전달
        }
    }
    
}
