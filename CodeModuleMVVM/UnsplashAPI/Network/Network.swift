//
//  Network.swift
//  CodeModuleMVVM
//
//  Created by Heedon on 2023/09/19.
//

import Foundation
import Alamofire

class Network {
    
    static let shared = Network()
    private init () { }
    
    //generic으로 하나로 대응
    //T: Decoding이 가능해야 함
    //여기서는 T를 매개변수로 명시적으로 나타내기 (메타타입 활용)
    func callRequest<T: Decodable>(type: T.Type, api: UnsplashAPI, completionHandler: @escaping (Result<T, StatusCodeError>) -> Void ) {
        
        AF.request(api.endPoint, method: api.method, parameters: api.query, encoding: URLEncoding(destination: .queryString), headers: api.headers).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data): completionHandler(.success(data))
            case .failure( _):
                let statusCode = response.response?.statusCode ?? 500
                guard let error = StatusCodeError(rawValue: statusCode) else { return }
                completionHandler(.failure(error))
            }
        }
        
    }
    
    //URLRequestConvertible 활용
    func requestConvertible<T: Decodable>(type: T.Type, api: Router, completionHandler: @escaping (Result<T, StatusCodeError>) -> Void ) {
        
        //proprety: private 설정 ~ 접근 불가 (컴파일 성능 고려, 추상화/모듈화)
        //URLRequestConvertible 채택한 enum 넣기
        //enum안에서 알아서 처리 --> 내부적으로 asURLRequest 메서드를 자동 호출
        AF.request(api).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data): completionHandler(.success(data))
            case .failure( _):
                let statusCode = response.response?.statusCode ?? 500
                guard let error = StatusCodeError(rawValue: statusCode) else { return }
                completionHandler(.failure(error))
            }
        }
    }

    
}
