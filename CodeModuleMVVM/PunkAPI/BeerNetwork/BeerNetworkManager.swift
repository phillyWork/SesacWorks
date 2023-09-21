//
//  BeerNetworkManager.swift
//  CodeModuleMVVM
//
//  Created by Heedon on 2023/09/19.
//

import Foundation
import Alamofire

final class BeerNetworkManager {
    
    static let shared = BeerNetworkManager()
    private init () { }
    
    func callRequest<T:Decodable>(type: T.Type, api: BeerAPI, completionHandler: @escaping (Result<T, BeerError>) -> Void )  {
        
        AF.request(api.endPoint, method: api.method).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(.success(value))
            case .failure(let failure):
                guard let statusCode = response.response?.statusCode, let error = BeerError(rawValue: statusCode) else {
                    print("Unknown Error occurred: ", failure.localizedDescription)
                    return
                }
                completionHandler(.failure(error))
            }
        }
        
    }
    
}
