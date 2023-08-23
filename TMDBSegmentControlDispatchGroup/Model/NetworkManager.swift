//
//  NetworkManager.swift
//  TMDBSegmentControlDispatchGroup
//
//  Created by Heedon on 2023/08/18.
//

import Foundation
import Alamofire

class NetworkManager {
    
    //https://api.themoviedb.org/3/movie/{movie_id}/similar?language=ko-KR&page={page_num}
    //https://api.themoviedb.org/3/movie/{movie_id}/videos?language=ko-KR

    private let headers: HTTPHeaders = [
      "accept": "application/json",
      "Authorization": "Bearer \(APIKey.tmdbAccessTokenAuth)"
    ]
    
    //Result type 녹이기: completionHandler 보낼 type으로 성공 케이스와 실패 케이스 묶어서 같이 보내기
    func fetchMovieList(type: EndPoint, movieId: Int, pageNum: Int, completionHandler: @escaping (Result<[Movie], AFError>) -> ()) {
        let url = URL.makeEndPoint("\(movieId)"+type.requestedUrl+"\(pageNum)")
        print(url)
                
        AF.request(url, method: .get, headers: headers).validate().responseDecodable(of: SimilarMovieList.self) { response in
            switch response.result {
            case .success(let value):
                print("Getting MovieList successful")
                completionHandler(.success(value.movieList))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }

    func fetchVideoList(type: EndPoint, movieId: Int, completionHandler: @escaping (Result<[Video], AFError>) -> ()) {
        let url = URL.makeEndPoint("\(movieId)"+type.requestedUrl)
        print(url)
        
        AF.request(url, method: .get, headers: headers).validate().responseDecodable(of: VideoList.self) { response in
            switch response.result {
            case .success(let value):
                print("Getting VideoList successful")
                completionHandler(.success(value.videoList))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
}
