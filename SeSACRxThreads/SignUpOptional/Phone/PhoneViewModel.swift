//
//  PhoneViewModel.swift
//  SeSACRxThreads_For_Assignment
//
//  Created by Heedon on 2023/11/02.
//

import Foundation

import RxSwift

final class PhoneViewModel {
    
    //TextField 입력값 받아 data update --> 다시 TextField에 전달
    let phoneNumber = BehaviorSubject(value: "010")
        
    //버튼 활성화 여부 결정 data
    let isButtonEnabled = BehaviorSubject(value: false)
    
    
    
}
