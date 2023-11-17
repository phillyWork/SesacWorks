//
//  KakaoAPIManager.swift
//  NetworkingProj
//
//  Created by Heedon on 2023/08/11.
//

import Foundation
import Alamofire
import SwiftyJSON

//Endpoint enum과 같이 활용
//link data와 link 연관 method 따로 나눠서 관리

class KakaoAPIManager {
    
    //singleton instance화
    static let shared = KakaoAPIManager()
    private init() { }
    
    
    //header에 authorization key를 넣는 경우
    //dictionary 형태, key-value로 넣기
    //HTTPHeaders type 맞게 설정
    //동일한 header 사용 반복 --> 외부로 내놓기
    let header: HTTPHeaders = ["Authorization": APIKey.kakaoAK]
    
    
    
    //request method
    //alamofire, swiftyJSON 활용 code
    //query 내용은 입력값에 따라 달라질 수 있음
    //type: 어떤 API 활용할 것인지에 따라 url 달라짐
    
    //completionHandler: 어떤 JSON 형태가 들어올지 들어올 당시에는 알 수 없음
    //들어온 JSON 가지고 활용하는 것을 closure로 처리하기
    func callRequest(query: String, type: EndPoint, completionHandler: @escaping (JSON) -> () ) {

        //한글: url이 인식할 수 있도록 encoding 필요
        //encoding 종류 다양함 (% 문자 처리 관련)
        guard let searchText = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("Cannot encode text!")
            return
        }
        
        //url 링크 생성, link대로 관리하기
//        let url = EndPoint.video.requestUrl
        
        //video 말고 여러 서비스 활용: 어떤 API 활용하는지 구분 필요
        let url = type.requestUrl + searchText
        
        AF.request(url, method: .get, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //json을 closure에 전달해서 closure에서 받은 json을 처리하도록 함
                completionHandler(json)
                
            case .failure(let error):
                print(error)
            }
        }
        
        
    }
    
    func callRequest(query: String, type: EndPoint, page: Int, completionHandler: @escaping (Result) -> () ) {
        //한글: url이 인식할 수 있도록 encoding 필요
        //encoding 종류 다양함 (% 문자 처리 관련)
        guard let searchText = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("Cannot encode text!")
            return
        }

//        let url = "https://dapi.kakao.com/v2/search/vclip?query=\(searchText)&size=10&page=\(page)"
        
        //video 말고 여러 서비스 활용: 어떤 API 활용하는지 구분 필요
        let url = type.requestUrl + "\(searchText)&size=10&page=\(page)"
        
        print("url: ", url)
        
        AF.request(url, method: .get, headers: header).validate().responseDecodable(of: Result.self) { response in
            guard let value = response.value else { return }
            completionHandler(value)
        }
        
    }
    
    
}
