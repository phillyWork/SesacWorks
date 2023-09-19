//
//  Extension+String.swift
//  iPadMVVMUnsplashAPI
//
//  Created by Heedon on 2023/09/11.
//

import Foundation

extension String {
    
    //연산 프로퍼티로 활용
    var localized: String {
        //comment: 부가적 설명, 보통은 잘 쓸 일이 없음
        return NSLocalizedString(self, comment: "")
    }
    
    //Int값을 String으로 변환, 대응하기
    func localized(number: Int) -> String {
        return String(format: self.localized, number)
    }
}
