//
//  SimpleValidationViewController.swift
//  RxSampleProjects
//
//  Created by Heedon on 2023/10/31.
//

import UIKit

import RxSwift
import RxCocoa

private let minimalUsernameLength = 5
private let minimalPasswordLength = 5

class SimpleValidationViewController: UIViewController {

    @IBOutlet weak var nameValidationInput: UITextField!
    @IBOutlet weak var nameValidationResultLabel: UILabel!

    @IBOutlet weak var passwordValidationInput: UITextField!
    @IBOutlet weak var passwordValidationResultLabel: UILabel!

    @IBOutlet weak var button: UIButton!
        
    let validationVM = ValidationViewModel()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        orEmptyShareExample()
    }

    func orEmptyShareExample() {
        nameValidationResultLabel.text = "Username has to be at least \(minimalUsernameLength) characters"
        passwordValidationResultLabel.text = "Password has to be at least \(minimalPasswordLength) characters"

        let usernameValid = nameValidationInput.rx.text.orEmpty
            .map { $0.count >= minimalUsernameLength }
            .share(replay: 1) // without this map would be executed once for each binding, rx is stateless by default

        let passwordValid = passwordValidationInput.rx.text.orEmpty
            .map { $0.count >= minimalPasswordLength }
            .share(replay: 1)

        //usernameValid와 passwordValid: RxCocoa에서 textField rx wrapping
        //ControlProperty로 유저와의 interaction subscribe 없이도 자동 방출
        //combineLatest에서 각 Observable 방출 필요하지만 UI 한정 빈값 방출
        //유저 입력값 변화 인지, 바로 작업
        let everythingValid = Observable.combineLatest(usernameValid, passwordValid) { $0 && $1 }
            .share(replay: 1)

        usernameValid
            .bind(to: passwordValidationInput.rx.isEnabled)
            .disposed(by: disposeBag)

        usernameValid
            .bind(to: nameValidationResultLabel.rx.isHidden)
            .disposed(by: disposeBag)

        passwordValid
            .bind(to: passwordValidationResultLabel.rx.isHidden)
            .disposed(by: disposeBag)

        everythingValid
            .bind(to: button.rx.isEnabled)
            .disposed(by: disposeBag)

        button.rx.tap
            .subscribe(onNext: { [weak self] _ in
                print("It's perfect")
            })
            .disposed(by: disposeBag)
    }
    
}
