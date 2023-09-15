//
//  APIService.swift
//  PhotoGram
//
//  Created by Heedon on 2023/08/30.
//

import Foundation

class APIService {
    
    //singleton 활용 --> instance 생성: 외부에서는 생성되지 않도록 함
    //shared만 활용하기, 여러 instance 생성되지 않도록 하기
    static let shared = APIService()
    
    //class: 기본적으로 가능 (internal로 설정됨)
    //의도적으로 외부에서 init 접근하지 못하도록 하기
    private init() { }
    
    func callRequest() {
        
        let url = URL(string: "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=1080")
        
        //고용량 사진 url
        //dataTask로는 처리 오래 걸림 --> downloadTask 활용하기
        let largeFileUrl = URL(string: "https://apod.nasa.gov/apod/image/2308/M66_JwstTomlinson_3521.jpg")
        
        //link정보: URLRequest
        //cache: web처럼 캐싱 정책
        //응답대기 기준시간보다 길어지는 경우: 실패로 간주 (timeout)

//        let request = URLRequest(url: url!)
        let request = URLRequest(url: largeFileUrl!)

        //URLSession: singleton instance 활용
        //여러 task 존재
        
        //completionHandler: 통신 응답구조 ~ data, response, error
        //다 optional인 이유?
        //성공: error가 nil
        //실패: data가 nil
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            print(data)
            print(response)
            print(error)
            
            //원하는 형태로 반환 필요: encoding으로 받아서 String으로 일단 보기
            let value = String(data: data!, encoding: .utf8)
            print(value)
            
        }.resume()      //network 통신 시작하기
        
    }
    
}
