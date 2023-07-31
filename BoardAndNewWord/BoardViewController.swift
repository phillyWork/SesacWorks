//
//  ViewController.swift
//  BoardAndNewWord
//
//  Created by Heedon on 2023/07/24.
//

import UIKit

class BoardViewController: UIViewController {

    //MARK: - Properties
    
    @IBOutlet var backgroundView: UIView!
    @IBOutlet var inputTextField: UITextField!
    @IBOutlet var confirmButton: UIButton!
    @IBOutlet var randomColorButton: UIButton!
    @IBOutlet var resultLabel: UILabel!
    
    //MARK: - Setup UI
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    
    func configUI() {
        view.backgroundColor = .black
        backgroundView.backgroundColor = .black
        configTextField()
        configButtons()
        configLabel()
    }

    func configTextField() {
        inputTextField.backgroundColor = .white
        inputTextField.textColor = .black
        inputTextField.font = .systemFont(ofSize: 16, weight: .medium)
        inputTextField.placeholder = "텍스트를 입력하세요."
    }
    
    func configButtons() {
        configConfirmButton()
        configRandomColorButton()
    }
    
    func configConfirmButton() {
        confirmButton.setTitleColor(.black, for: .normal)
        confirmButton.backgroundColor = .white
        confirmButton.clipsToBounds = true
        confirmButton.layer.cornerRadius = 5
        confirmButton.layer.borderColor = UIColor.black.cgColor
        confirmButton.layer.borderWidth = 1
    }
    
    func configRandomColorButton() {
        randomColorButton.setTitleColor(.systemRed, for: .normal)
        randomColorButton.backgroundColor = .white
        randomColorButton.clipsToBounds = true
        randomColorButton.layer.cornerRadius = 5
        randomColorButton.layer.borderColor = UIColor.black.cgColor
        randomColorButton.layer.borderWidth = 1
    }
    
    func configLabel() {
        resultLabel.font = .boldSystemFont(ofSize: 45)
        resultLabel.textColor = .systemRed
        resultLabel.textAlignment = .center
        resultLabel.backgroundColor = .black
        resultLabel.isHidden = true
    }
    
    //MARK: - API

    func createAlertForConfirmation(title: String, message: String, actionTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirm = UIAlertAction(title: actionTitle, style: .cancel)
        alert.addAction(confirm)
        present(alert, animated: true)
    }
    
    //엔터키 눌러 keyboard 내려갈 때 호출
    @IBAction func textFieldEnterKeyTapped(_ sender: UITextField) {
        //엔터키 누르면 확인 버튼 누른것과 동일한 효과 주기
        confirmButtonTapped(confirmButton)
    }
    
    
    //실질적으로 textField의 입력값 확인해서 label에 보여주기
    @IBAction func confirmButtonTapped(_ sender: UIButton) {
        //키보드 내리기
        view.endEditing(true)
        
        if inputTextField.hasText {
            //입력값 있으므로 결과값 보여주기
            if let text = inputTextField.text {
                resultLabel.text = text
                resultLabel.isHidden = false
            }
        } else {    //입력값 없다면 입력값 필요함 alert 띄우기
            resultLabel.isHidden = true
            createAlertForConfirmation(title: "입력 오류", message: "텍스트를 입력해야 입력값이 나타납니다.", actionTitle: "확인")
            return
        }
        
        
    }
    
    //randomColorButton과 resultLabel 컬러 변경하기
    @IBAction func randomColorButtonTapped(_ sender: UIButton) {
        let cgRed = CGFloat.random(in: 0...1)
        let cgGreen = CGFloat.random(in: 0...1)
        let cgBlue = CGFloat.random(in: 0...1)
        let alpha = CGFloat.random(in: 0...1)
        let randomColor = UIColor(cgColor: CGColor(red: cgRed, green: cgGreen, blue: cgBlue, alpha: alpha))
        
        randomColorButton.setTitleColor(randomColor, for: .normal)
        resultLabel.textColor = randomColor
    }
    
    @IBAction func areaTapped(_ sender: UITapGestureRecognizer) {
        //이외 영역 누르면 키보드 내리기
        view.endEditing(true)
        //상위view isHidden -> 하위view도 같이 hidden
        backgroundView.isHidden.toggle()
        
    }

}

