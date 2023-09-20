//
//  Router+UnsplashAPI.swift
//  CodeModuleMVVM
//
//  Created by Heedon on 2023/09/20.
//

import Foundation
import Alamofire

//더 강제화된 구조 설정 가능 (기준점 설정해줌)
//private 은닉화 설정, 외부에서 활용 가능하도록

//Alamofire protocol
enum Router: URLRequestConvertible {
    
    //기존 enum에서 필요한 요소들은 그대로 활용 O
    case search(query: String)
    case random
    case single(id: String)

    //외부 파일에서 사용할 일 없이 enum 안에서만 활용
    //private으로 은닉화 가능
    
    private var headers: HTTPHeaders {
        ["Authorization": "Client-ID \(APIKey.accessKey)"]
    }
    
    private var method: HTTPMethod {
        return .get
    }
    
    //type을 더 맞게 활용하기
    
    //String --> URL
    private var baseURL: URL {
        return URL(string: "https://api.unsplash.com/")!
    }

    //endPoint: URL type --> path: String type, url 자리 ~ 기능분리
    private var path: String {
        switch self {
        case .search:
            return "search/photos"
        case .random:
            return "photos/random"
        case .single(let id):
            return "photos/\(id)"
        }
    }
    
    
    //URLRequestConvertible 필수 구현 함수
    func asURLRequest() throws -> URLRequest {
        //내부에서 data 구성, 결과 기반으로 통신함
        
        //case 선택 --> 내부적으로 가지고 있는 endPoint 활용

        //type 변환: 최종 URL 만들기
        //명료하게 url 구성하기: baseURL에 path를 붙이기
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
//        var request = URLRequest(url: path)
        
        //network 규약 구성하기
        //header 구성
        request.headers = headers

        //method 설정
        request.method = method
        
        
        
        
        return request
    }
    
    
    
    
    
}
