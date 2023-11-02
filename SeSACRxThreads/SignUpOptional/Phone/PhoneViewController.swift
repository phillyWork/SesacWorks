//
//  PhoneViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//
 
import UIKit

import SnapKit
import RxSwift
import RxCocoa

class PhoneViewController: UIViewController {
   
    let phoneTextField = SignTextField(placeholderText: "연락처를 입력해주세요")
    let nextButton = PointButton(title: "다음")
    
    //조건 여부 따라 달라지는 버튼 색상
    let buttonColor = BehaviorSubject(value: UIColor.red)
    
    let disposeBag = DisposeBag()
    
    let phoneVM = PhoneViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Color.white
        
        configureLayout()
        
        bind()
        
        nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
    }
    
    func bind() {
        
        //phoneNumber로부터 처리된 Bool data 기반으로 button 활성화 결정
        //먼저 연결해놓아야 data 변경 반영 가능
        phoneVM.isButtonEnabled
            .bind(to: nextButton.rx.isEnabled)
            .disposed(by: disposeBag)

        //해당 값 textField에 나타내기
        phoneVM.phoneNumber
            .bind(to: phoneTextField.rx.text)
            .disposed(by: disposeBag)
        
        phoneVM.phoneNumber
            //Rx: closure 처리 --> 메모리 누수 고려
            //UI update: main thread 보장 필요
            .observe(on: MainScheduler.instance)
            //자리수 따지기: String --> Bool로 타입 변환
            .map { $0.count > 10 }
            .subscribe(with: self) { owner, value in
                let color = value ? UIColor.blue : UIColor.red
                //해당 색상 버튼 컬러에 전달
                owner.buttonColor.onNext(color)
                //활성화 여부 전달
                owner.phoneVM.isButtonEnabled.onNext(value)
            }
            .disposed(by: disposeBag)
        
            
        //해당 color를 button과 textField tintColor에 적용
        buttonColor
            .bind(to: nextButton.rx.backgroundColor, phoneTextField.rx.tintColor)
            .disposed(by: disposeBag)
        
        //CGColor: 다른 타입
        //map으로 타입 변화
        buttonColor
            .map { $0.cgColor }
            .bind(to: phoneTextField.layer.rx.borderColor)
            .disposed(by: disposeBag)
        
        //textField 내 입력값 변화하면 다시 phone에게 전달하기
        //orEmpty: nil값 처리 operator
        phoneTextField.rx.text.orEmpty
            .subscribe { value in
                //중간 - 입력하기 (숫자만 입력, 다른 String값 입력 막기)
                let result = value.formated(by: "###-####-####")
                self.phoneVM.phoneNumber.onNext(result)
            }
            .disposed(by: disposeBag)
    }
    
    
    @objc func nextButtonClicked() {
        navigationController?.pushViewController(NicknameViewController(), animated: true)
    }

    
    func configureLayout() {
        view.addSubview(phoneTextField)
        view.addSubview(nextButton)
         
        phoneTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(phoneTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }

}
