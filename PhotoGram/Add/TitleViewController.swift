//
//  TitleViewController.swift
//  PhotoGram
//
//  Created by Heedon on 2023/08/29.
//

import UIKit

class TitleViewController: BaseViewController {

    let titleView = TitleView()
    
    //closure로 값 전달하기
    //1. function type 명시 --> optional로 지정
    var completionHandler: ((String) -> Void)?
    
    var completionHandlerVariousTypes: ((String, Int, Bool) -> ())?
    
    override func loadView() {
        self.view = titleView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //완전히 사라진 후 호출 --> 입력값 전달하기
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        //closure로 값 전달하기
        //2. optional chaining, String값 전달하며 completionHandler 실행하기
        //completionHandler: 어떤 함수가 들어올지는 모름, 실행 타이밍만 설정
        completionHandler?(titleView.textField.text ?? "There's no title!!!")
        
        completionHandlerVariousTypes?(titleView.textField.text!, 100, true)
    }
    
    override func configViews() {
        super.configViews()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(doneButtonTapped))
    }
    
    override func setConstraints() {
        super.setConstraints()
    }
   
    
    @objc func doneButtonTapped() {
        print(#function)        //함수 호출 여부, 기본 동작 확인 후에 로직 작성하기
        //completionHandler 호출
        completionHandler?(titleView.textField.text ?? "There's no title!!!")
        
        completionHandlerVariousTypes?(titleView.textField.text!, 77, false)
        
        //화면 닫기
        navigationController?.popViewController(animated: true)
    }

}
