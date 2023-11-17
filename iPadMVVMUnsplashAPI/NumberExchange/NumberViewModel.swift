//
//  NumberViewModel.swift
//  iPadMVVMUnsplashAPI
//
//  Created by Heedon on 2023/09/18.
//

import Foundation

class NumberViewModel {
    
    //textField와 label에 보여줄 text값 (data handling용)
    var dollarText: Observable<String?> = Observable("1000")    //Optional 대응용
    var exchangeResult = Observable("1,327,000")
    
    //연산 로직
    func exchange() {
        print("before update: ", dollarText.value, exchangeResult.value)
        
        //필요 연산: 빈 값, 문자열, 환전 한도 범주...
        guard let text = dollarText.value else {
            exchangeResult.value = "값을 입력해주세요"
            return
        }
        
        guard let textToNumber = Int(text) else {
            exchangeResult.value = "숫자를 입력해주세요"
            return
        }
        
        guard textToNumber > 0, textToNumber <= 1000000 else {
            exchangeResult.value = "환전 범주는 100만원 이하입니다."
            return
        }
        
        //예외 처리 이후 잘 나타나도록 보여주기 (쉼표 표현)
        let exchangeNumber = textToNumber * 1327
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal

        let decimalNumber = numberFormatter.string(for: exchangeNumber)!

        exchangeResult.value = "환전 금액은 \(decimalNumber)원 입니다."
        
        print("after update: ", dollarText.value, exchangeResult.value)
    }
    
}
