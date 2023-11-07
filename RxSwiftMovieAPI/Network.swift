//
//  Network.swift
//  RxSwiftMovieAPI
//
//  Created by Heedon on 2023/11/07.
//

import Foundation

import RxSwift
import RxCocoa

enum NetworkError: Error {
    
    case invalidURL
    case notSuccessfulStatusCode
    case notDecodable
    case unknown
    
}

final class Network {
    
    static func fetchDataFromMovieAPI(date: String) -> Observable<MovieStruct> {
        
        return Observable.create { observer in
            
            guard let url = URL(string: "https://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(APIKey.boxOfficeKey)&targetDt=\(date)") else {
                
                //not available url
                observer.onError(NetworkError.invalidURL)
                return Disposables.create()
            }

            URLSession.shared.dataTask(with: url) { data, response, error in
                
                if let _ = error {
                    observer.onError(NetworkError.unknown)
                    return
                }
                
                guard let response = response as? HTTPURLResponse,  (200...299).contains(response.statusCode) else {
                    observer.onError(NetworkError.notSuccessfulStatusCode)
                    return
                }
                
                if let data = data {
                    do {
                        let decodedData = try JSONDecoder().decode(MovieStruct.self, from: data)
                        observer.onNext(decodedData)
                    } catch {
                        observer.onError(NetworkError.notDecodable)
                    }
                }
            }.resume()
            
            return Disposables.create()
        }
        
    }
    
    
}
