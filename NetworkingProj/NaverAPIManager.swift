//
//  NaverAPIManager.swift
//  NetworkingProj
//
//  Created by Heedon on 2023/08/11.
//

import Foundation
import Alamofire
import SwiftyJSON

class NaverAPIManager {
    
    static let shared = NaverAPIManager()
    private init() {}
    
    
    //VC에서 입력한 text 매개변수로 받기
    //번역 결과 String을 VC에서 어떻게 처리할지 closure에 전달하기
    
    //closure 내에 네트워킹 작업 (closure 내 closure)
    //네트워킹: global async로 수행
    //networking closure 작업 다 끝나고 resultString call해야 함

    //타이밍 잡기 어려움
    
    //callRequest가 종료된 이후에 response 가지고 활용하기: "탈출시키기" @escaping
    
    func callRequest(text: String, resultString: @escaping (String) -> Void) {
        let translateUrl = "https://openapi.naver.com/v1/papago/n2mt"
        
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.naverClientID,
            "X-Naver-Client-Secret": APIKey.naverClientSecret
        ]
        
        let parameters: Parameters = [
            "source": "ko",
            "target": "en",
            "text": text
        ]
        
        AF.request(translateUrl, method: .post, parameters: parameters, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                
                var result = JSON(value)["message"]["result"]["trasnlatedText"].stringValue
                
                print("result: ", result)
                
                if result.isEmpty {
                    result = "번역을 할 수 없습니다."
                }
                
                //closure에 전달
                resultString(result)
                
            case .failure(let error):
                print("Error: ", error.localizedDescription)
            }
        }
    }
    
}
