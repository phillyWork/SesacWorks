//
//  LoginViewController.swift
//  iPadMVVMUnsplashAPI
//
//  Created by Heedon on 2023/09/12.
//

import UIKit

class LoginViewController: UIViewController {

    //MARK: - Properties
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    let viewModel = LoginViewModel()
    
    //MARK: - Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //String인 경우
//        //선언 & 초기화: class instance 생성, 내부의 property에 접근 가능
////        let sample = Observable()
//
//        //선언만 해놓음: init으로 초기화 필요
//        let sample = Observable(value: "오레오")
//        sample.value
//
//        //property 접근, 값 변경
//        //property는 값 변경되는 신호 받고 싶음
//        //property observer인 didSet 달기
////        sample.value = "고래밥"
//
//
//        //bind 기능: ViewController에서 작성, 함수 전달받을 수도 있음
//        sample.bind { text in
//            print("LoginVC bind closure", text)
//        }
//
//        //sample의 value 값 변경
//        //값이 변경되니까 올라가서 역 실행 (코드 흐름 역으로 올라감)
//        sample.value = "3456"
//
//        sample.value = "986"
        
        
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    
        
        
        //viewModel 활용
        
        //사용자 기입할 때마다 호출
        //data 변경될 때마다 viewModel에 data 업데이트
        idTextField.addTarget(self, action: #selector(idTextFieldChanged), for: .editingChanged)
        pwTextField.addTarget(self, action: #selector(pwTextFieldChanged), for: .editingChanged)
        
        //값이 변경될 때마다 호출: textField에 바뀐 값을 보여주기
        viewModel.id.bind { text in
            print("Bind id", text)
            self.idTextField.text = text
        }
        
        viewModel.pw.bind { text in
            //password는 변경값 model에 update 되도록 설정하지 않음 --> validation 기준 맞아도 true 나타나지 않음
            print("Bind pw", text)
            self.pwTextField.text = text
        }
        
        //isValid가 true, false인지에 따른 정의
        viewModel.isValid.bind { bool in
            self.loginButton.isEnabled = true
            self.loginButton.backgroundColor = bool ? .green : .lightGray
        }
        
    }
        
    //MARK: - Handlers
    
    @objc func idTextFieldChanged() {
        print("===")
        
        //입력 바뀔 때마다 viewModel에 data update 요청
        viewModel.id.value = idTextField.text!
        
        //입력값 변화할 때마다 validation 점검하기
        viewModel.checkValidation()
    }
    
    
    @objc func pwTextFieldChanged() {
        //viewModel에 update된 데이터 전달
        viewModel.pw.value = pwTextField.text!
        
        viewModel.checkValidation()
    }
    
    
    
    @objc func loginButtonTapped() {
        //입력값 유효성 평가
        
        //데이터 받아서 가공 (판단 조건)
        //모두 다 Controller가 할 필요는 없다
        
        guard let id = idTextField.text, let pw = pwTextField.text else { return }
        
        if id.count >= 6 && pw == "1234" {
            print("로그인 했어요")
        } else {
            print("로그인 실패")
        }
        
        
        //로그인 관련 로직 처리 후 (VC는 정확하게 어떤 로직인지 모름)
        viewModel.signIn {
            //로그인 성공/실패 alert 띄우기
            print("로그인 성공/실패 따른 alert 띄우기")
        }
        
    }
    
  
    
    
    
    

}
