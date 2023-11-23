//
//  NicknameViewModel.swift
//  SeSACRxThreads_For_Assignment
//
//  Created by Heedon on 2023/11/02.
//

import Foundation

import RxSwift

final class NicknameViewModel {
    
    let nickname = BehaviorSubject(value: "닉네임")
    let isNickNameNotInRange = BehaviorSubject(value: true)
    
    
    
}
