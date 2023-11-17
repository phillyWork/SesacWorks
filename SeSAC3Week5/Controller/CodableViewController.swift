//
//  CodableViewController.swift
//  SeSAC3Week5
//
//  Created by Heedon on 2023/08/16.
//

import UIKit
import Alamofire


//error handling: 명확한 오류에 대한 정의
//Error protocol 채택, 각 case에 대한 대응 처리하도록 함

//enum 활용 --> compile 때 오류 타입 알 수 있음
enum ValidationError: Error {
    case emptyString
    case isNotInt
    case isNotDate
}
//status code 고려 ~ 각 case에 Int값 줄 수도 있음


//SwiftyJSON: JSONSerialization 기반, update 늦어짐
//Codable 활용해서 덜어내기 작업

class CodableViewController: UIViewController {
    
    //Weather API
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    //번역 결과 담기
    var resultText = "Apple"
    
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var checkButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        callWeather()
        
//        fetchLottoData()
        
        //번역 후 재번역 적용해보기
//        fetchTranslateData(source: "ko", target: "en", text: "안녕하세요")
//        fetchTranslateData(source: "en", target: "ko", text: resultText)
        
        //결과: 번역된 결과로 재번역하지 않음
        //response 올 때까지 기다리지 않고 바로 실행함
        
        //연달아 통신 진행: 결과값 연계해서 활용: 함수 내 함수로 작성
//        fetchTranslateDataTwice(source: "ko", target: "en", text: "안녕하세요")
        
    }
    
    //MARK: - Weather API
    func callWeather() {
        
        //원하는 String만 가져오기
        //WeatherManager.shared.callRequestString { temp, humidity in
        //            self.tempLabel.text = temp
        //            self.humidityLabel.text = humidity
        //        }
                
        
        //json 통으로 VC에 넘기기
        //        WeatherManager.shared.callRequestJSON { json in
        //            let tempCelsius = json["main"]["temp"].doubleValue - 273.15
        //            let humidity = json["main"]["humidity"].intValue
        //
        //            self.tempLabel.text = "\(tempCelsius)"
        //            self.humidityLabel.text = "\(humidity)"
        //        }
        
        
        //Codable로 struct 통째로 데이터 받아서 넣기
        WeatherManager.shared.callRequestCodable { data in
            
            self.tempLabel.text = "\(data.main.temp)"
            self.humidityLabel.text = "\(data.main.humidity)"
            
        } failure: { error in
            print(error)
    
            //if alert 띄우기: ViewController에서 처리 (present method 활용)
            
        }

    }
    
    
    
    
    
    @IBAction func checkButtonTapped(_ sender: UIButton) {
        
        guard let text = inputTextField.text else { return }
        
        //조건문 활용 시
        //        if validateUserInput(text: text) {
        //            print("검색 가능. 네트워크 통신 시작")
        //        } else {
        //            print("검색 불가.")
        //        }
        
        
        //error handling 활용 시
        //throw한 error들을 받을 곳이 필요
        do {
            //정상적 실행: Bool type의 true 받음
            let result = try validateUserInputErrorHandling(text: text)
            
            //다른 기능 활용 가능
//            callRequest()
            
            //오류 발생: ValidatinoError type 받음
        } catch {
            print("Error")
            //switch case로 error 구분 가능
        }
    
    //        catch ValidationError.emptyString {
    //            print(ValidationError.emptyString)
    //        } catch ValidationError.isNotDate {
    //            print(ValidationError.isNotDate)
    //        } catch ValidationError.isNotInt {
    //            print(ValidationError.isNotInt)
    //        }
    
    
        //다른 방식: 오류가 나타나지 않는 상황 가정 시
        //오류 100% 없다: try! 사용 가능
        let example = try? validateUserInputErrorHandling(text: text)
        //nil 처리
        if example == nil {
            
        }
        
    }
    
    //error handling 따로 활용하는 이유
    //단순 선택보단 정상적 로직 이외의 case를 관리하기 위함
    //명확한 오류에 대한 정의 필요 with enum
    func validateUserInputErrorHandling(text: String) throws -> Bool {
        //Do-Try-Catch 활용 with enum

        //true: 정상적인 상황
        //false --> 명확한 오류 지점 작성 (throw error)
        
        guard !text.isEmpty else {
            print("빈 값")
            throw ValidationError.emptyString
        }
        
        guard Int(text) != nil else {
            print("숫자 아님")
            throw ValidationError.isNotInt
        }
        
        guard checkDateFormat(text: text) else {
            print("날짜 형식 아님")
            throw ValidationError.isNotDate
        }
        
        return true
    }
    

    func validateUserInput(text: String) -> Bool {
        //조건문, guard 활용해서 에러 대응하기
        
        //BoxOffice API query 요구사항
        //1. 8글자
        //2. 날짜 형식 변환 가능
        //3. 숫자만
        
        guard !text.isEmpty else {
            print("빈 값")
            return false
        }
        
        guard Int(text) != nil else {
            print("숫자 아님")
            return false
        }
        
        guard checkDateFormat(text: text) else {
            print("날짜 형식 아님")
            return false
        }
        
        return true
    }
    
    
    //dateFormatter 체크하기
    func checkDateFormat(text: String) -> Bool {
        let format = DateFormatter()
        format.dateFormat = "yyyyMMdd"
        
        let result = format.date(from: text)
        
        return result != nil ? true : false
    }
    
    
    
    //MARK: - Network Call Lotto API

    //AlamoFire response method 모음
    //내부적 코드로 global 혹은 main으로 왔다갔다 함
    //따로 DispatchQueue.global.async, main.async로 처리하지 않아도 알아서 설정해줌
    
    //request는 순서대로 처리, response 시점은 순서대로 안 올 수 있음: 순서 보장되지 않음
    func fetchLottoData() {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=1080"
        
        //오래 걸리는 작업: 동기처리는 UI 상호작용도 막음
        //네트워크 통신: 다른 thread에 분배해서 처리해야 함 (비동기 처리)
//        DispatchQueue.global().async {
            AF.request(url, method: .get).validate()
                .responseData { response in
                    guard let value = response.value else { return }
                    print("responseData:", value)
                    
//                    //UI update: main thread에서
//                    DispatchQueue.main.async {
//                        //e.g.) label에 숫자 출력
//
//                    }
                }
//        }
        
        AF.request(url, method: .get).validate()
            .responseString { response in
                guard let value = response.value else { return }
                print("responseString:", value)
            }
        
        AF.request(url, method: .get).validate()
            .response { response in
                guard let value = response.value else { return }
                print("response:", value)
            }
         
        //Decodable: String 기반 response의 데이터를 받을 struct/class 필요
        
        AF.request(url, method: .get).validate()
            .responseDecodable(of: Lotto.self) { response in
                guard let value = response.value else { return }
                print("responseDecodable:", value)
            }

    }
    
    
    //MARK: - Network Call inside of Network Call
    
    func fetchTranslateData(source: String, target: String, text: String) {
        
        print("fetchTranslateData", source, target, text)
        
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": Key.naverClientID,
            "X-Naver-Client-Secret": Key.naverClientSecret
        ]
        let parameters: Parameters = [
            "source": source,
            "target": target,
            "text": text
        ]
        
        //default: validate code 200...299 --> 상태 실패 코드만 알려주고 끝
        //validate 범주 늘려보면서 어떤 오류인지 확인 가능
        AF.request(url, method: .post, parameters: parameters, headers: header)
            .validate(statusCode: 200...500)
            .responseDecodable(of: Translation.self) { response in
                
                //오류 확인 목적
                print(response)
                
                //실제 데이터 받기
                guard let value = response.value else { return }
                print(value)
                
                //실제 원하는 번역 결과로 update
                self.resultText = value.message.result.translatedText
            }

    }
    
    func fetchTranslateDataProgress(source: String, target: String, text: String) {
        
        print("fetchTranslateData", source, target, text)
        
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": Key.naverClientID,
            "X-Naver-Client-Secret": Key.naverClientSecret
        ]
        let parameters: Parameters = [
            "source": source,
            "target": target,
            "text": text
        ]
        
        AF.request(url, method: .post, parameters: parameters, headers: header)
            .validate(statusCode: 200...500)
            .responseDecodable(of: Translation.self) { response in
                
                guard let value = response.value else { return }
                
                //실제 원하는 번역 결과로 update
                self.resultText = value.message.result.translatedText
                
                //연달아 통신 진행: 결과값 연계해서 활용 --> 함수 내에서 다시 통신 진행
                self.fetchTranslateDataProgress(source: "en", target: "ko", text: self.resultText)
                
                //재귀적으로 호출
                //문제: 탈출할 포인트 없음, 무한 루프로 호출
            }
    }
    
    func fetchTranslateDataTwice(source: String, target: String, text: String) {
        
        print("fetchTranslateData", source, target, text)
        
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": Key.naverClientID,
            "X-Naver-Client-Secret": Key.naverClientSecret
        ]
        let parameters: Parameters = [
            "source": source,
            "target": target,
            "text": text
        ]
        
        AF.request(url, method: .post, parameters: parameters, headers: header)
            .validate(statusCode: 200...500)
            .responseDecodable(of: Translation.self) { response in
                
                guard let value = response.value else { return }
                
                self.resultText = value.message.result.translatedText
                
                //연달아 통신 진행: 결과값 연계해서 활용 --> 함수 내에서 다시 통신 진행
                //재귀적으로 호출
                //문제: 탈출할 포인트 없음, 무한 루프로 호출
                
                //해결: 다른 함수 이름으로 함수 정의, 다른 이름으로 호출
                self.fetchTranslateData(source: "en", target: "ko", text: self.resultText)
            }
    }
    
    
    // MARK: - Lotto
    struct Lotto: Codable {
        let totSellamnt: Int
        let returnValue, drwNoDate: String
        let firstWinamnt, drwtNo6, drwtNo4, firstPrzwnerCo: Int
        let drwtNo5, bnusNo, firstAccumamnt, drwNo: Int
        let drwtNo2, drwtNo3, drwtNo1: Int
    }

    
    //MARK: - Translation
    
    //Data depth: Translation --> Message --> Result
    struct Translation: Codable {
        let message: Message
    }

    // MARK: - Message
    struct Message: Codable {
        let service, version: String
        let result: Result
        let type: String

        enum CodingKeys: String, CodingKey {
            case service = "@service"
            case version = "@version"
            case result
            case type = "@type"
        }
    }

    // MARK: - Result
    struct Result: Codable {
        let engineType, tarLangType, translatedText, srcLangType: String
    }

    
    
    
}
