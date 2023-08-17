//
//  NetworkManager.swift
//  TMDBAPICallTwiceInARow
//
//  Created by Heedon on 2023/08/16.
//

import Foundation
import Alamofire

class NetworkManager {
    
    private let headers: HTTPHeaders = [
      "accept": "application/json",
      "Authorization": "Bearer \(APIKey.tmdbAccessTokenAuth)"
    ]
    
    //trending TV: https://api.themoviedb.org/3/trending/tv/{time_window}
    //--> id 활용: tv series detail: https://api.themoviedb.org/3/tv/{series_id}
    //--> id, season_number 활용 seasons detail: https://api.themoviedb.org/3/tv/{series_id}/season/{season_number}

    
    //trendTV list에서 해당 작품 선택 --> 상세 페이지 넘어와서 해당 작품의 id로 시즌과 관련 에피소드 API 통신
    //여기서는 일단 id로 37854 얻었다고 가정 (애니메이션 원피스)
    
    
//    func fetchTrendTV(type: EndPoint, completionHandler: @escaping (TrendTVResult) -> ()) {
//        let url = type.requestUrl
//        AF.request(url, method: .get, headers: headers).validate().responseDecodable(of: TrendTVResult.self) { response in
//            completionHandler(response.value!)
//        }
//    }
    
    func fetchTVDetail(type: EndPoint, seriesId: Int, completionHandler: @escaping ([Season]) -> ()) {
        let url = type.requestUrl + "\(seriesId)"
        
        AF.request(url, method: .get, headers: headers).validate().responseDecodable(of: TVDetail.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value.seasons)
            case .failure(let error):
                print("Error: ", error.localizedDescription)
            }
        }
    }
    
    func fetchSeasonDetail(type: EndPoint, seriesId: Int, seasonNumber: Int, success: @escaping ([Episode]) -> (), failure: @escaping (AFError) -> ()) {
        let url = type.requestUrl + "\(seriesId)/season/\(seasonNumber)"
        print("About to call request episode")
        AF.request(url, method: .get, headers: headers).validate().responseDecodable(of: SeasonDetail.self) { response in
//            print("response: \(response)")
            switch response.result {
            case .success(let value):
                print("value: \(value)")
                success(value.episodes)
            case .failure(let error):
                print("Error: ", error.localizedDescription)
                failure(error)
            }
        }
    }
    
    
}
