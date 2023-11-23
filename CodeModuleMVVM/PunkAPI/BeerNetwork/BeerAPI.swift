//
//  BeerAPI.swift
//  CodeModuleMVVM
//
//  Created by Heedon on 2023/09/19.
//

import Foundation
import Alamofire

enum BeerAPI {
    
    case multiple(page: Int)
    case single(id: Int)
    case random
    
    var baseURL: String {
        return "https://api.punkapi.com/v2/beers"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var endPoint: URL {
        switch self {
        case .multiple(let page):
            return URL(string: baseURL + "?page=\(page)")!
        case .single(let id):
            return URL(string: baseURL + "/\(id)")!
        case .random:
            return URL(string: baseURL + "/random")!
        }
    }
    
    
}
