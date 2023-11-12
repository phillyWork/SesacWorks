//
//  ViewModel.swift
//  CodeModuleMVVM
//
//  Created by Heedon on 2023/09/20.
//

import Foundation

final class ViewModel {
    
    let network = Network.shared
    
    func request(completionHandler: @escaping (URL) -> Void ) {
        //Router 활용: 구현부 달라지는 것은 없음
        network.requestConvertible(type: PhotoResult.self, api: .random) { response in
            switch response {
            case .success(let success):
                dump(success)
                
                //VC로 image 전달하기: completionHandler 활용
                //전달: response 그 자체 / String type의 url / URL 그 자체
                
                //UI: URL 변환 식도 연산 ~ URL 전달해주기
                completionHandler(URL(string: success.urls.thumb)!)
                
                //link 활용해서 image 가져오기
//                self.imageView.kf.setImage(with: URL(string:success.urls.thumb)!)
                
            case .failure(let failure):
                print(failure.errorDescription)
            }
        }
    }
    
    
}
