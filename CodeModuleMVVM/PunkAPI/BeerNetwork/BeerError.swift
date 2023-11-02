//
//  BeerError.swift
//  CodeModuleMVVM
//
//  Created by Heedon on 2023/09/19.
//

import Foundation

enum BeerError: Int, Error {
    case noParameter = 400
    
    var errorMessage: String {
        switch self {
        case .noParameter:
            return "잘못된 검색입니다. 다시 입력해주세요."
        }
    }
    
}
