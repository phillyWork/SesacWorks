//
//  NetworkManager.swift
//  BeerAndLotteryAPI
//
//  Created by Heedon on 2023/09/13.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() { }
    
    func searchUrl(number: Int, completionHandler: @escaping (Result<Lotto, AFError>) -> ()) {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(number)"
        
        AF.request(url, method: .get).validate().responseDecodable(of: Lotto.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(.success(value))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
