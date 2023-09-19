//
//  StatusCode.swift
//  CodeModuleMVVM
//
//  Created by Heedon on 2023/09/19.
//

import Foundation

//Alamofire도 자체 정의 존재 (AFError)
//Result: Error protocol return --> Alamofire: Error 기반 AFError 활용

//상태코드 변경 있을 수 있음 --> case로 구조화 (수정 용이, case 추가 유연)
//LocalizedError: 각 지역 설정에 따른 에러 설명
enum StatusCodeError: Int, Error, LocalizedError {
    
    case missingParameter = 400
    case unauthorized = 401
    case permissionDenied = 403
    case invalidServer = 500

    //상태코드에 대한 String값 주기
    var errorDescription: String {
        switch self {
        case .missingParameter:
            return "검색어를 입력해주세요"
        case .unauthorized:
            return "인증 정보가 없습니다"
        case .permissionDenied:
            return "권한이 없습니다"
        case .invalidServer:
            return "서버 점검 중입니다"
        }
    }
    
    
}
