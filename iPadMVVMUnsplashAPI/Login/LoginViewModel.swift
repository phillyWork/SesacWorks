//
//  LoginViewModel.swift
//  iPadMVVMUnsplashAPI
//
//  Created by Heedon on 2023/09/12.
//

import Foundation

class LoginViewModel {
    
    //1. data 관련 모두 viewModel로 이관
    
    //Observable instance로 변경될 때마다 전달 받음
    var id = Observable("a@a.com")
    var pw = Observable("123")
    

    var isValid = Observable(false)
    
    //VC에서 하던 로직 이동
    //입력값 유효성 검증 메서드
    
    //VC는 어떤 로직으로 유효성 검사하는지 모름 (검사 결과만 알고 있음)
    func checkValidation() {
        if id.value.count >= 6 && pw.value.count >= 4 {
            isValid.value = true
        } else {
            isValid.value = false
        }
    }
    
    
    //sign-in method 구성
    func signIn(completionHandler: @escaping () -> Void) {
        //서버 혹은 UserDefaults에 닉네임, id/email 저장하기
        UserDefaults.standard.set(id.value, forKey: "id")
        
        //alert로 저장 완료 알리기: completionHandler 활용
        completionHandler()
        
    }
    
    
}
