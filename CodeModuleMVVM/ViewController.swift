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

    //network 통신 함수 모두 network 기능 singleton이 담당
    let networkBasic = NetworkBasic.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        callRequest(query: "sky")
//        callRandomReqeust()
//        callSingleRequest(id: "mfb_evGFm78")
        
        
        networkBasic.callRequest(query: "sky") { response in
            switch response {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print(failure)

                
            }
        }
        
        
        
        
        
//        //completionHandler 대응: 2가지 매개변수 활용
//        networkBasic.callRandomReqeust { photo, error in
//            //optional binding으로 해제 필요: 둘 다 nil일 수 있음
//            //photo와 error 공존할 수 없음을 인지하고 작성해야 함
//
//            if let error {}             //error 존재 여부 확인
//        }

                
        //completionHandler 대응: Result type 활용
        networkBasic.callSingleRequest(id: "mfb_evGFm78") { response in
            //성공과 실패만 대응: switch (optional binding 처리 없음)
            switch response {
            //성공과 실패일 때의 각각의 data 전달
            case .success(let success):
                print("UI update or data 저장 등...")
                print(success)
            case .failure(let failure):
                print("다시 시도해주세요 관련 alert")
                print(failure)
            }
        }
        
    }

    
    

}

