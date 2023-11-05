//
//  CalculateViewModel.swift
//  iPadMVVMUnsplashAPI
//
//  Created by Heedon on 2023/09/13.
//

import Foundation

class CalculateViewModel {
    
    //VC에 나타낼 data
    //VC는 어떤 data가 들어있는지 알지 못함, 어떤 UI component에 보여줄지만 알고 있음
    
    //Observable instance로 활용 --> data 변화마다 원하는 코드 실행하기
    
    //Optional 대응하기
    var firstNum: CalculateObservable<String?> = CalculateObservable("10")
    var secondNum: CalculateObservable<String?> = CalculateObservable("20")
    
    var resultText = CalculateObservable("결과는 30입니다.")
    
    var tempText = CalculateObservable("테스트 위한 텍스트")
    
    //덧셈 연산 처리
    func calcualte() {
        
        //firstNum와 secondNum 더해서 resultText에 적용하기
        
        //optioanl 처리, 숫자 판단
        guard let first = firstNum.value, let firstConvert = Int(first) else {
            //오류 났음 알려주기 (예외 처리)
            resultText.value = "첫번째 값에서 오류 발생"
            return
        }
                
        guard let second = secondNum.value, let secondConvert = Int(second) else {
            resultText.value = "두번째 값에서 오류 발생"
            return
        }
        
        //resultText update
        //resultText 값 변화: didSet block 실행
        //변경된 data를 label에 반영할 것
        resultText.value = "결과는 \(firstConvert + secondConvert)입니다"
        
    }
    
    
    
    //lotto API 당첨금 관련...
    //날짜 관련, 숫자 표현 처리 관련: formatter 활용
    func format(for number: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(for: number)!
    }

    //숫자를 쉼표 있는 표현으로 나타내기 연산
    func presentNumberFormat() {
        guard let first = firstNum.value, let firstConvert = Int(first) else {
            tempText.value = "숫자로 변환할 수 없는 문자"
            return
        }
        
        //바뀐 값을 decimal style로 update하기
        tempText.value = format(for: firstConvert)
    }
    
    
}
