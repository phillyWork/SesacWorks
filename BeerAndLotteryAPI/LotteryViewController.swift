//
//  LotteryViewController.swift
//  BeerAndLotteryAPI
//
//  Created by Heedon on 2023/08/07.
//

import UIKit
import Alamofire
import SwiftyJSON

class LotteryViewController: UIViewController {

    //MARK: - Properties
    
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    let data: [Int] = Array(1...1100).reversed()
    
    let pickerView = UIPickerView()
    
    //MARK: - Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    
    
    //MARK: - API
    
    func searchUrl(number: Int) {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(number)"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
//                print("JSON: \(json)")
                
                switch json["returnValue"].stringValue {
                case "success":
                    self.resultLabel.text = "로또 번호는 다음과 같습니다."
                    
                    let result1 = json["drwtNo1"].stringValue
                    let result2 = json["drwtNo2"].stringValue
                    let result3 = json["drwtNo3"].stringValue
                    let result4 = json["drwtNo4"].stringValue
                    let result5 = json["drwtNo5"].stringValue
                    let result6 = json["drwtNo6"].stringValue
                    let bonus = json["bnusNo"].stringValue
                    
                    self.numberLabel.text = "\(result1) • \(result2) • \(result3) • \(result4) • \(result5) • \(result6 ) + Bonus: \(bonus)"
                    
                    
                    self.resultLabel.isHidden = false
                    self.numberLabel.isHidden = false
                case "fail":
                    self.resultLabel.text = "Something wrong with session, Try Again"
                    
                    self.resultLabel.isHidden = false
                    self.numberLabel.isHidden = true
                default:
                    break
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    

}

//MARK: - Extension for PickerView Delegate, DataSource

extension LotteryViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let selectedData = data[row]
        
        inputTextField.text = "\(selectedData)"
        
        searchUrl(number: selectedData)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(data[row])"
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
        inputTextField.placeholder = "회차를 선택해주세요"
        inputTextField.inputView = pickerView
        inputTextField.tintColor = .clear
        
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    func configLabel() {
        resultLabel.textColor = .black
        resultLabel.textAlignment = .center
        resultLabel.isHidden = true
        
        numberLabel.textColor = .black
        numberLabel.textAlignment = .center
        numberLabel.isHidden = true
    }
    
    
}
