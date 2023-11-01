//
//  NicknameViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

class NicknameViewController: UIViewController {
   
    let nicknameTextField = SignTextField(placeholderText: "닉네임을 입력해주세요")
    let nextButton = PointButton(title: "다음")
    
    let nickname = BehaviorSubject(value: "닉네임")
    let isNickNameNotInRange = BehaviorSubject(value: true)
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Color.white
        
        bind()
        
        configureLayout()
       
        nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)

    }
    
    func bind() {
        
        //버튼 숨김 여부 먼저 bind로 전달해놓기
        isNickNameNotInRange
            .bind(to: nextButton.rx.isHidden)
            .disposed(by: disposeBag)
        
        //textField에 전달해서 띄우기
        nickname
            .bind(to: nicknameTextField.rx.text)
            .disposed(by: disposeBag)
        
        nickname
            .map { $0.count < 2 || $0.count > 6 }
            .subscribe(with: self) { owner, value in
                owner.isNickNameNotInRange.onNext(value)
            }
            .disposed(by: disposeBag)
        
        //textField 새로운 입력값 data에 전달
        nicknameTextField.rx.text.orEmpty
            .bind(to: nickname)
            .disposed(by: disposeBag)
        
    }
    
    @objc func nextButtonClicked() {
        navigationController?.pushViewController(BirthdayViewController(), animated: true)
    }

    
    func configureLayout() {
        view.addSubview(nicknameTextField)
        view.addSubview(nextButton)
         
        nicknameTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(nicknameTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }

}
