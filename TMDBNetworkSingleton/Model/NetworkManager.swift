//
//  NetworkManager.swift
//  TMDBNetworkSingleton
//
//  Created by Heedon on 2023/08/11.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    //MARK: - GET
    
    private let timeWindow = "day"
    
    private let headers: HTTPHeaders = [
      "accept": "application/json",
      "Authorization": "Bearer \(APIKey.tmdbAccessTokenAuth)"
    ]
    
    //DataManager에서 JSON response 처리
    func callRequest(type: EndPoint, movieId: Int?, page: Int?, completionHandler: @escaping (JSON) -> ()) {
        var url: String
        switch type {
        case .trendMovie:
            if let page = page {
                url = type.requestURL + timeWindow + "?page=\(page)"
            } else {
                url = type.requestURL + timeWindow
            }
        case .movieCasting:
            if let movieId = movieId {
                url = type.requestURL + "\(movieId)/credits"
            } else {
                print("MovieId is required!")
                return
            }
        }
        
        AF.request(url, method: .get, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                //genre API 재호출
//                AF.request(<#T##convertible: URLRequestConvertible##URLRequestConvertible#>)
                
                completionHandler(json)
            case .failure(let error):
                print("Error: ", error.localizedDescription)
            }
        }
    }
    
    
    func callTrendMovieRequestWithDecodableStructure(type: EndPoint, page: Int, completionHandler: @escaping (Result<[Movie], AFError>) -> ()) {
        
        let url = type.requestURL + timeWindow + "?page=\(page)"
        
        //Decodable with JSON depth data structure
        //모든 data 포괄하는 가장 최상단 구조체 활용
        AF.request(url, method: .get, headers: headers).validate()
            .responseDecodable(of: MovieTrend.self) { response in
                switch response.result {
                case .success(let value):
                    print("Getting MovieList successful")
                    completionHandler(.success(value.movieList))
                case .failure(let error):
                    print("Failed to get movie list")
                    completionHandler(.failure(error))
                }
//                completionHandler(response.result)
//                completionHandler(response.value!)
            }
    }
    
    func callCasintListRequestWithDecodableStructure(type: EndPoint, movieId: Int, completionHandler: @escaping (Result<[Cast], AFError>) -> ()) {
        
        let url = type.requestURL + "\(movieId)/credits"
        
        //Decodable with JSON depth data structure
        //모든 data 포괄하는 가장 최상단 구조체 활용
        AF.request(url, method: .get, headers: headers).validate()
            .responseDecodable(of: CastingList.self) { response in
                switch response.result {
                case.success(let value):
                    print("Getting CastList successful")
                    completionHandler(.success(value.cast))
                case .failure(let error):
                    print("Failed to get cast list")
                    completionHandler(.failure(error))
                }
//                completionHandler(response.result)
//                completionHandler(response.value!)
            }
    }
    
        
}
