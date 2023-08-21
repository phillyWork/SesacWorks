//
//  WeatherManager.swift
//  SeSAC3Week5
//
//  Created by Heedon on 2023/08/17.
//

import Foundation
import Alamofire
import SwiftyJSON

class WeatherManager {
    
    static let shared = WeatherManager()

    func callRequestString(completionHandler: @escaping (String, String) -> ()) {
        
        //required: 위도, 경도, API Key
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=\(Key.weatherKey)"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
//                print("JSON: \(json)")
                
                //parsing: 한 레벨씩 차근차근 들어가는 것
                
                //온도: 절대온도 기준
                let tempCelsius = json["main"]["temp"].doubleValue - 273.15
                let humidity = json["main"]["humidity"].intValue
//                print("온도는 \(tempCelsius)도, 습도는 \(humidity)% 입니다.")
                
                
                //VC에서는 바로 데이터를 화면에 전달 가능
                //manager로  기능 분리: closure 활용, VC로 해당 data 전달하기

//                self.tempLabel.text = "\(tempCelsius)"
//                self.humidityLabel.text = "\(humidity)"
                
                completionHandler("\(tempCelsius)도 입니다", "\(humidity)% 입니다")
                            
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func callRequestJSON(completionHandler: @escaping (JSON) -> ()) {
        
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=\(Key.weatherKey)"
        
        AF.request(url, method: .get).validate(statusCode: 200...500).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                completionHandler(json)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //성공, 실패 2가지 나눠서 closure 활용
    func callRequestCodable(success: @escaping (WeatherData) -> (), failure: @escaping (AFError) -> ()) {
        
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=\(Key.weatherKey)"
        
        AF.request(url, method: .get).validate(statusCode: 200...500).responseDecodable(of: WeatherData.self) { response in
            switch response.result {
            case .success(let value): success(value)
            case .failure(let error): failure(error)
            }
        }
        
    }
    
}
