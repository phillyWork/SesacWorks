//
//  LotteryViewController.swift
//  BeerAndLotteryAPI
//
//  Created by Heedon on 2023/08/07.
//

import UIKit

class LotteryViewController: UIViewController {

    //MARK: - Properties
    
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!

    let viewModel = LotteryViewModel()
    
    let pickerView = UIPickerView()
    
    //MARK: - Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        searchUrl(number: 1079)
        configUI()
        
        //값 변경 시 수행할 listener 정의
        viewModel.lottoDrawing.bind { number in
            //pickerView 선택 결과 표시
            self.inputTextField.text = number
            
            //해당 값으로 네트워크 통신 수행
            self.viewModel.callReqeust(number: number)
        }
        
        //nework 성공 결과로 값 변경 시 수생할 listener 정의
        viewModel.lottoResult.bind { lotto in
            //결과를 view에 보여주기
            self.numberLabel.text = lotto?.resultNumberList
        }
        
        //결과 나타내기
        viewModel.resultText.bind { text in
            //pickerView 선택 결과 정수형 변환 실패, 네트워크 실패인 경우 값 변화
            self.resultLabel.text = text
        }
        
    }
    
}

//MARK: - Extension for PickerView Delegate, DataSource

extension LotteryViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.numberOfRowsInComponent()
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //Int --> String으로 변환 후, 해당 값으로 lottoDrawing 값 update --> update된 값으로 listener 실행
        viewModel.convertToStringForLottoDrawing(row: row)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.pickerTitle(row: row)
    }

}


//MARK: - Extension for UI

extension LotteryViewController {
    
    func configUI() {
        configTextField()
        configLabel()
    }
    
    func configTextField() {
        inputTextField.textColor = .black
        inputTextField.placeholder = BlankSpace.placeholder.rawValue
        inputTextField.inputView = pickerView
        inputTextField.tintColor = .clear
        
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    func configLabel() {
        resultLabel.textColor = .black
        resultLabel.textAlignment = .center
        resultLabel.text = viewModel.resultText.value
        
        numberLabel.textColor = .black
        numberLabel.textAlignment = .center
        numberLabel.text = BlankSpace.blank.rawValue
    }
    
}



//MARK: - Before MVVM

//    func searchUrl(number: Int) {
//        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(number)"
//
//        AF.request(url, method: .get).validate().responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                let json = JSON(value)
////                print("JSON: \(json)")
//
//                switch json["returnValue"].stringValue {
//                case "success":
//                    self.resultLabel.text = "로또 번호는 다음과 같습니다."
//
//                    let result1 = json["drwtNo1"].stringValue
//                    let result2 = json["drwtNo2"].stringValue
//                    let result3 = json["drwtNo3"].stringValue
//                    let result4 = json["drwtNo4"].stringValue
//                    let result5 = json["drwtNo5"].stringValue
//                    let result6 = json["drwtNo6"].stringValue
//                    let bonus = json["bnusNo"].stringValue
//
//                    self.numberLabel.text = "\(result1) • \(result2) • \(result3) • \(result4) • \(result5) • \(result6 ) + Bonus: \(bonus)"
//
//
//                    self.resultLabel.isHidden = false
//                    self.numberLabel.isHidden = false
//                case "fail":
//                    self.resultLabel.text = "Something wrong with session, Try Again"
//
//                    self.resultLabel.isHidden = false
//                    self.numberLabel.isHidden = true
//                default:
//                    break
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
