//
//  URLSessionViewController.swift
//  PhotoGram
//
//  Created by Heedon on 2023/08/30.
//

import UIKit

class URLSessionViewController: UIViewController {
    
    var session: URLSession!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let largeFileUrl = URL(string: "https://apod.nasa.gov/apod/image/2308/M66_JwstTomlinson_3521.jpg")
        
        //property에 instance 할당하기
        //진행율 확인: Delegate 활용 필요 --> shared 대신 default session 활용
        
        //URLSessionConfiguration: 환경설정
        //Delegate: delegate 담당 설정
        
        //delegateQueue: 응답 받음 --> 어떤 스레드에서 처리? (OperationQueue)
        //진행 과정 보여주기: UI에 나타내기
        session = URLSession(configuration: .default, delegate: self, delegateQueue: .main)
        
        //dataTask로 task 처리하기 without completionHandler
        //resume 필요
        session.dataTask(with: largeFileUrl!).resume()
    }
    
}

//MARK: - Extension URLSession Delegate

//Task 종류 따라 Delegate 달라짐
extension URLSessionViewController: URLSessionDataDelegate {
    
    //통신 최초 응답 받은 경우 호출: 시작 지점 (상태 코드 처리 필요)
//    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse) async -> URLSession.ResponseDisposition {
//        print("RESPONSE: ", response)
//    }
    
    //통신 과정 데이터 받을 때마다 반복 호출: 중간 과정
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {

        //최초 응답 메서드에서 full size 알려줌
        //full size 아는 경우: 매번 받을 때 용량 알 수 있으므로 %로 진행률 나타낼 수 있음
        print("DATA: ", data)
        
    }
    
    //통신 완료 이후 호출: 완료 시점
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        print("END")
    }
    
    
    
}
