//
//  UpbitAPI.swift
//  SwiftUICoinOrderBook
//
//  Created by Heedon on 11/21/23.
//

import Foundation

//Identifiable protocol: 정보가 고유하지 않다면 id로 고유성 보장하기

struct Market: Codable, Hashable {
    
    let market: String
    let korean: String
    let english: String
    
    //member와 갑 구분할 것 아니라면 case 그대로 작성 (String type으로 rawValue 제공)
    enum CodingKeys: String, CodingKey {
        case market
        case korean = "korean_name"
        case english = "english_name"
    }
    
}

struct UpbitAPI {
    
    private init() { }
    
    static func fetchAllMarket(completionHandler: @escaping ([Market]) -> Void) {
        
        let url = URL(string: "https://api.upbit.com/v1/market/all")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            //에러, 상태코드는 생략
            
            guard let data = data else {
                print("데이터 응답 없음")
                return
            }
            
            do {
                //배열로 들어오는 Market --> 처음 받을때는 배열로 담아야 함
                let decodedData = try JSONDecoder().decode([Market].self, from: data)
                print("data 확인 목적: ", decodedData)
                
                //URLSession: concurrent하게 처리 기본
                //main thread에서 처리하도록
                DispatchQueue.main.async {
                    completionHandler(decodedData)
                }
            } catch {
                print(error)
            }
            
            
            
        }.resume()
        
    }
    
}
