//
//  Extension.swift
//  PhotoGram
//
//  Created by Heedon on 2023/08/29.
//

import Foundation

//type 확장 활용 ~ e.g.) UIButton.configuration extension으로 활용
extension Notification.Name {
    //String literal 직접 입력 대신 활용
    static let selectImage = NSNotification.Name("SelectImage")
}

