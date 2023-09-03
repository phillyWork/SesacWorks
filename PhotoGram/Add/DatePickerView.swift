//
//  DatePickerView.swift
//  PhotoGram
//
//  Created by Heedon on 2023/08/29.
//

import UIKit

class DatePickerView: BaseView {
    
    let datePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .wheels   //크기 기본 설정되어 있음
        picker.datePickerMode = .date
        return picker
    }()
    
    override func configViews() {
        super.configViews()
        addSubview(datePicker)
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        datePicker.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
        }
        
    }
    
}
