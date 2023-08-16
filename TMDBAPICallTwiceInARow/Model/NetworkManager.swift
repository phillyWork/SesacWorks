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
            guard let value = response.value else { return }
            completionHandler(value.seasons)
        }
    }
    
    func fetchSeasonDetail(type: EndPoint, seriesId: Int, seasonNumber: Int, completionHandler: @escaping ([Episode]) -> ()) {
        let url = type.requestUrl + "\(seriesId)/season/\(seasonNumber)"
        
        AF.request(url, method: .get, headers: headers).validate().responseDecodable(of: SeasonDetail.self) { response in
            guard let value = response.value else { return }
            completionHandler(value.episodes)
        }
    }
    
}
