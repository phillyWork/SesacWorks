//
//  CalculateViewController.swift
//  iPadMVVMUnsplashAPI
//
//  Created by Heedon on 2023/09/13.
//

import UIKit

class CalculateViewController: UIViewController {
    
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    //viewModel로부터 데이터 받아오기
    let viewModel = CalculateViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //VC: data type도 관심 없음
        //형변환 or type 맞춰주기도 VM에서 처리
        //viewModel에서 초기값 넘어옴
        firstTextField.text = viewModel.firstNum.value
        secondTextField.text = viewModel.secondNum.value
        resultLabel.text = viewModel.resultText.value
        
        //textField값 변화 ~ viewModel에 data update하도록 알리기
        firstTextField.addTarget(self, action: #selector(firstTextFieldChanged), for: .editingChanged)
        secondTextField.addTarget(self, action: #selector(secondTextFieldChanged), for: .editingChanged)
        
        //특정 view와 특정 data "bind 하기" (값이 바뀔 때마다 어떤 기능 작동할 지 작성)
        //listener에 해당 closure 할당 ~ 이후 값이 변화할 때마다 계속해서 listener 실행으로 closure 실행함
        
        //closure block 내용: 값이 변화되면 해당 UI component에 변화된 값을 나타내도록 하기 (display)
        viewModel.firstNum.bind { number in
            self.firstTextField.text = number
            print("firstNum changed to \(number)")
            
            //바뀐 값을 tempLabel 쉼표 표시된 값으로 나타내기
            self.viewModel.presentNumberFormat()
        }
        
        viewModel.secondNum.bind { number in
            self.secondTextField.text = number
            print("secondNum changed to \(number)")
        }
        
        viewModel.resultText.bind { text in
            self.resultLabel.text = text
        }
        
        
        //tempText 값 변화할 때마다 변화된 값을 tempLabel에 나타내기
        viewModel.tempText.bind { text in
            self.tempLabel.text = text
        }
        
        
    }
    
    
    //변화 시점의 메서드
    @objc func firstTextFieldChanged() {
        //value update 되어야 함 알림
        
        //text property: Optional String값
        //예외처리: ViewModel에 맡길 경우 --> Observable에서 optional 대응하기
        viewModel.firstNum.value = firstTextField.text
        
        //값 변화 --> 변화된 값으로 덧셈 연산 처리하도록 하기 (viewModel 담당)
        viewModel.calcualte()
    }
    
    @objc func secondTextFieldChanged() {
        viewModel.secondNum.value = secondTextField.text
        
        viewModel.calcualte()
    }
    
    
}


//MARK: - Observable 사용 이해

/*
 //일반적인 class instance 생성
 //최초 생성: name property에 값을 넣는 것
 //wildcard 식별자 활용, 외부 매개변수 숨기기
 let person = CalculateObservable("새싹")
 
 //instance 생성 이후: name property의 값 변화
 //didSet이 감지, block 내 코드 실행
 //luckyNumber에 아직 할당되지 않음: nil이므로 0 출력
 person.value = "고래밥"
 person.value = "칙촉"
 
 //기능 활용: 메서드 호출 --> 매개변수를 활용하기 --> wildcard 식별자 활용, 외부 매개변수 숨기기
 //매개변수 값을 luckyNumber property에 할당
         
 //매개변수에 closure 추가
//        person.introduce(Int.random(in: 1...10)) {
 
 //매개변수에 String --> VC에 전달해서 나타내기
 person.bind { value in
     self.resultLabel.text = value
     
     //intrdouce 메서드 호출 시 view의 backgroundColor 변경하기
     //closure로 활용 (view: VC에만 존재)
     
     //escaping으로 함수 밖에 존재해야 하기 때문 --> self로 view의 주인: ViewController임 알리기
     self.view.backgroundColor = [UIColor.orange, UIColor.lightGray, UIColor.magenta].randomElement()!
     
 }
 
 
 //introduce 메서드로 listener에 closure 할당 (연결)
 //그 이후로는 값 변경될 때마다 didSet에서 listener 실행 ~ 연결된 clsoure 실행
 
 //delay 옵션 주기: 몇 초 뒤에 실행할지
 DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
     //name property 다시 update: didSet에서 설정한 luckyNumber property까지 같이 활용 (nil값 아님)
     person.value = "바나나"
     print("====1초 뒤====")
 }
 
 DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
     //name property 다시 update: didSet에서 설정한 luckyNumber property까지 같이 활용 (nil값 아님)
     person.value = "키위"
     print("====3초 뒤====")
 }
 */
