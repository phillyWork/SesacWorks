//
//  AddView.swift
//  PhotoGram
//
//  Created by Heedon on 2023/08/28.
//

import UIKit

//AddVC의 rootView 역할
class AddView: BaseView {
    
    //VC내 view code도 반복
    //BaseView 만들어서 상속, 해당 VC의 view로 활용하기
    let photoImageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let searchButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        return button
    }()
    
    //pickerButton과 동일 역할, 코드 확인용 한번 더
    let searchProtocolButton = {
        let button = UIButton()
        button.backgroundColor = .systemPink
        return button
    }()
    
    //datePickerVC로 이동할 버튼
    let pickerButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        //static func 활용
        button.setTitle(DateFormatter.today(), for: .normal)
//        button.setTitle("23년 8월 29일", for: .normal)
        return button
    }()
    
    let titleButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitle("오늘의 사진", for: .normal)
        return button
    }()
    
    let subTitleButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitle("subTitle입니다", for: .normal)
        return button
    }()
    
    override func configViews() {
        //super class에서 별도 작업하는 코드가 없다면 super 메서드 호출하지 않아도 됨
        super.configViews()
        
        //AddVC가 아니라 view 구성을 자기 자신에게 하기 (self 활용 가능)
        addSubview(photoImageView)
        addSubview(searchButton)
        
        addSubview(searchProtocolButton)
        
        addSubview(pickerButton)
        
        addSubview(titleButton)
        
        addSubview(subTitleButton)
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        //AddVC의 view 대신 AddView 자기 자신으로 설정
        photoImageView.snp.makeConstraints { make in
            
            //기본 margin 8 설정 유무 차이
//            make.topMargin.leadingMargin.trailingMargin.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.top.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(2)        //10-8
            make.height.equalTo(self).multipliedBy(0.3)
        }
        
        searchButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.bottom.trailing.equalTo(photoImageView)
        }
        
        
        searchProtocolButton.snp.makeConstraints { make in
            make.size.equalTo(searchButton)
            make.leading.bottom.equalTo(photoImageView)
        }
        
        pickerButton.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(50)
        }
        
        titleButton.snp.makeConstraints { make in
            make.top.equalTo(pickerButton.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(50)
        }
     
        subTitleButton.snp.makeConstraints { make in
            make.top.equalTo(titleButton.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(50)
        }
        
        
    }
    
}
