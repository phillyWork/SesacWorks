//
//  ViewController.swift
//  CodeModuleMVVM
//
//  Created by Heedon on 2023/09/19.
//

import UIKit
import Alamofire
import SnapKit

class ViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        callRequest(query: "sky")
//        callRandomReqeust()
        callSingleRequest(id: "mfb_evGFm78")
    }

    
    func callRequest(query: String) {
        
        //query: utf-8 encode
        
        //search photo
        let url = "https://api.unsplash.com/search/photos"
        
        //header에 key 숨기기 (보안)
        //HTTPHeaders(headers)로 type 설정 가능 (headers: dictionary로 type 추론된 상황)
        let headers: HTTPHeaders = [
            "Authorization": "Client-ID \(APIKey.accessKey)"
        ]
    
        //Parameters: POST때 활용 --> image, file, 대용량 텍스트 가능 (대량 data를 서버에 추가하듯)
        //e.g.) 번역 API
        //HTTPBody에 실어 보냄

        //query도 숨기기 (url 간단하게 하기): GET ~ 정보 정확하게 요청 (queryString) --> 제약 O: 자리수, 이미지 불가 등등... (간소한 data)
        //GET임을 알리기: encoding 활용 (default 설정: httpBody) --> destination: queryString 설정
        let query: Parameters = [
            "query": query
        ]
        
        //response: DataResult
        AF.request(url, method: .get, parameters: query, encoding: URLEncoding(destination: .queryString), headers: headers).responseDecodable(of: Photo.self) { response in
            switch response.result {
            
            case .success(let data): dump(data)
                
            case .failure(let error): print(error)
                
            }
        }

    }
    
    func callRandomReqeust() {
        
        //get a random photo
        let url = "https://api.unsplash.com/photos/random"
        
        let headers: HTTPHeaders = [
            "Authorization": "Client-ID \(APIKey.accessKey)"
        ]
    
//        let query: Parameters = [
//            "query": query
//        ]
        
        //구조 동일: 동일한 struct 재활용하기
        AF.request(url, method: .get, headers: headers).responseDecodable(of: PhotoResult.self) { response in
            switch response.result {
            
            case .success(let data): dump(data)
                
            case .failure(let error): print(error)
                
            }
        }
        
        
    }
    

    func callSingleRequest(id: String) {
        //get a single photo detail
        
        //id: queryString으로 들어가지 않음
        let url = "https://api.unsplash.com/photos/\(id)"
        
        let headers: HTTPHeaders = [
            "Authorization": "Client-ID \(APIKey.accessKey)"
        ]
        
        AF.request(url, method: .get, headers: headers).responseDecodable(of: PhotoResult.self) { response in
            switch response.result {
            
            case .success(let data): dump(data)
                
            case .failure(let error): print(error)
                
            }
        }
        
        
        
        
    }
    

}

