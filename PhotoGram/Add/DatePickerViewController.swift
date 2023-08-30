//
//  DatePickerViewController.swift
//  PhotoGram
//
//  Created by Heedon on 2023/08/29.
//

import UIKit

class DatePickerViewController: BaseViewController {

    let pickerView = DatePickerView()

    //protocol Delegate 값 전달
    //2. protocol 보유 (실질적인 작업: 다른 VC에서 수행)
    var delegate: PassDataDelegate?
    
    override func loadView() {
        self.view = pickerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        //protocol Delegate 값 전달
        //3. protocol의 필수 함수 실행 타이밍 설정
        delegate?.receiveDate(date: pickerView.datePicker.date)     //화면 닫고 난 뒤, 날짜 정보를 delegate 역할할 곳에 전달하기
    }
    
}
