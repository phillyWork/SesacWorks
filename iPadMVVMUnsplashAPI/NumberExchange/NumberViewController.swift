//
//  NumberViewController.swift
//  iPadMVVMUnsplashAPI
//
//  Created by Heedon on 2023/09/18.
//

import UIKit

class NumberViewController: UIViewController {
    
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    //viewModel instance
    let viewModel = NumberViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindData()
        
        numberTextField.addTarget(self, action: #selector(numberTextFieldChanged), for: .editingChanged)
                
    }
    
    
    //bind 작업들: 메서드로 분리
    func bindData() {
        //viewModel의 property 값 변화 시 작업할 내용 연결
        viewModel.dollarText.bind { value in
            self.numberTextField.text = value
        }
        
        viewModel.exchangeResult.bind { result in
            self.resultLabel.text = result
        }
    }
    

    //ViewController에 다 넣은 경우
//    @objc func numberTextFieldChanged() {
//
//        //필요 연산: 빈 값, 문자열, 환전 한도 범주...
//        guard let text = numberTextField.text else {
//            resultLabel.text = "값을 입력해주세요"
//            return
//        }
//
//        guard let textToNumber = Int(text) else {
//            resultLabel.text = "숫자를 입력해주세요"
//            return
//        }
//
//        guard textToNumber > 0, textToNumber <= 1000000 else {
//            resultLabel.text = "환전 범주는 100만원 이하입니다."
//            return
//        }
//
//        //예외 처리 이후 잘 나타나도록 보여주기 (쉼표 표현)
//        let exchangeNumber = textToNumber * 1327
//
//        let numberFormatter = NumberFormatter()
//        numberFormatter.numberStyle = .decimal
//
//        let decimalNumber = numberFormatter.string(for: exchangeNumber)!
//
//        resultLabel.text = "환전 금액은 \(decimalNumber)원 입니다."
//
//    }
    
    
    //ViewModel로 비즈니스 로직 이관한 경우
    //VC는 어떤 데이터 가지고 작업하는 지 관심 없음, UI와 연결만 하기
    @objc func numberTextFieldChanged() {
        print(#function)
        
        //값이 바뀔 때 viewModel에 바뀐 data(새로운 입력값) 전달해야 함
        viewModel.dollarText.value = numberTextField.text
        
        viewModel.exchange()
    }
    
    
}
