//
//  ViewController.swift
//  iPadMVVMUnsplashAPI
//
//  Created by Heedon on 2023/09/11.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var changeButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Localizable.Strings 활용
//        nicknameTextField.placeholder = NSLocalizedString("nickname_placeholder", comment: "")
        
        //연산 프로퍼티로 활용 (String Literal은 enum으로 연결해놓을 수도 있음)
        nicknameTextField.placeholder = "nickname_placeholder".localized
        
        //String data 대응: %@에 가변 매개변수 값이 들어감
        //매개변수 개수 설정은 Localizable.strings와 동일해야 함
        let value = NSLocalizedString("nickname_result", comment: "")
        resultLabel.text = String(format: value, "고래밥")
        
        
        //Int를 String으로 변환해서 적용
        resultLabel.text = "age_result".localized(number: 55)
    
        
        //상수 활용, property 할당 시 중복되는 상수 작성
        //CMD + CTRL + E: scope 내 해당 요소 모두 선택 가능 --> 각주는 포함되지 않음
        let searchBar = UISearchBar()
        searchBar.text = "ASDF"
        searchBar.placeholder = "asdfsdf"
        searchBar.delegate
        searchBar.showsCancelButton = true
        
        //option + 해당 영역 클릭: 그 만큼 커서 잡힘
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)  //Ctrl + Shift + 해당 위치 클릭
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(#function)  //Ctrl + Shift + 해당 위치 클릭
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(#function)  //Ctrl + Shift + 해당 위치 클릭
    }
    
    

}

