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
                completionHandler(json)
            case .failure(let error):
                print("Error: ", error.localizedDescription)
            }
        }
    }
        
}
