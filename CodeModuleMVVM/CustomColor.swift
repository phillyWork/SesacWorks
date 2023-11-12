//
//  CustomColor.swift
//  CodeModuleMVVM
//
//  Created by Heedon on 2023/09/22.
//

import UIKit

enum CustomColor {
    
    //역할에 맞는 color 구분: 범주 구체화
    enum text {
        static let title = UIColor(named: "title")!
        
    }
    
    enum Button {
        
    }
    
    enum View {
        static let background = UIColor(named: "background")!
    }
    
}


enum CustomImage {
    
    enum Image {
        //light, dark용 컬러 설정
        //tabbar, navigation icon color: 원하는 컬러 설정
        static let star = UIImage(systemName: "star")!.withRenderingMode(.alwaysOriginal).withTintColor(CustomColor.text.title)
    }
    
}
