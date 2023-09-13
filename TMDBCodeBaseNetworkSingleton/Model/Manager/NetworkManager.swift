//
//  NetworkManager.swift
//  TMDBCodeBaseNetworkSingleton
//
//  Created by Heedon on 2023/08/28.
//

import Foundation
import Alamofire

class NetworkManager {
    
    private let headers: HTTPHeaders = [
        "accept": "application/json",
        "Authorization": "Bearer \(APIKey.tmdbAccessTokenAuth)"
    ]
    
    //MARK: - Generic Function for callRequest
    
    func callRequest<T: Codable>(type: DataUrl, page: Int?, movieId: Int?, seriesId: Int?, seasonNumber: Int?, completionHandler: @escaping (Result<T, AFError>) -> ()) {
        
        var url: String = ""
        
        //url 설정
        switch type {
        case .trendAll, .trendMovie, .trendTV:
            if let page = page {
                url = type.requestURL + "?page=\(page)"
            } else {
                url = type.requestURL
            }
        case .movieCasting:
            if let movieId = movieId {
                url = type.requestURL + "\(movieId)/credits"
            }
        case .tvCasting:
            if let seriesId = seriesId {
                url = type.requestURL + "\(seriesId)/credits"
            }
        case .seasonDetail:
            if let seriesId = seriesId {
                url = type.requestURL + "\(seriesId)"
            }
        case .episodeDetail:
            if let seriesId = seriesId, let seasonNumber = seasonNumber {
                url = type.requestURL + "\(seriesId)/season/\(seasonNumber)"
            }
        case .similarMovie:
            if let movieId = movieId, let page = page {
                url = URL.makeDataURLString("movie/\(movieId)"+type.requestURL+"\(page)")
            }
        case .similarTV:
            if let seriesId = seriesId, let page = page {
                url = URL.makeDataURLString("tv/\(seriesId)"+type.requestURL+"\(page)")
            }
        case .videoMovie:
            if let movieId = movieId {
                url = URL.makeDataURLString("movie/\(movieId)"+type.requestURL)
            }
        case .videoTV:
            if let seriesId = seriesId {
                url = URL.makeDataURLString("tv/\(seriesId)"+type.requestURL)
            }
            
        }
        
        //실제 원하는 배열 데이터 보다 한단계 위의 데이터 전달하기
        //DataManager에서 큰 데이터 받아서 필요한 배열 데이터 확보하고 활용하기
        AF.request(url, method: .get, headers: headers).validate().responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                print("Getting data succeed")
                completionHandler(.success(value))
            case .failure(let error):
                print("Getting data failed")
                completionHandler(.failure(error))
            }
        }
        
    }
    
}
