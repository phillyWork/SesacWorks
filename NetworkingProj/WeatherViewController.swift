//
//  WeatherViewController.swift
//  NetworkingProj
//
//  Created by Heedon on 2023/08/08.
//

import UIKit
import Alamofire
import SwiftyJSON

class WeatherViewController: UIViewController {

    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        callRequest()
        
    }
    
    func callRequest() {
        
        //required: 위도, 경도, API Key
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=\(APIKey.weatherKey)"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                //parsing: 한 레벨씩 차근차근 들어가는 것
                
                //온도: 절대온도 기준
                let tempCelsius = json["main"]["temp"].doubleValue - 273.15
                let humidity = json["main"]["humidity"].intValue
//                print("온도는 \(tempCelsius)도, 습도는 \(humidity)% 입니다.")
                
                self.tempLabel.text = "\(tempCelsius)"
                self.humidityLabel.text = "\(humidity)"
                
                //weather: openweather에서 weather condition 만들어 놓음 (id에 따라 해당 날씨 정해줌)
                //배열 형태: index 작성 필요
                let id = json["weather"][0]["id"].intValue
                
                switch id {
                case 800:
                    self.weatherLabel.text = "매우 맑음"
                case 801..<900:
                    self.weatherLabel.text = "구름이 낀 날씨입니다"
                    self.view.backgroundColor = .lightGray
                default:
                    self.weatherLabel.text = "나머지는 각자 날씨 코드를 보고 확인하세요..."
                }
                
                //response가 성공이면 view를 갱신함
                
            case .failure(let error):
                print(error)
            }
        }
        
    }


}
