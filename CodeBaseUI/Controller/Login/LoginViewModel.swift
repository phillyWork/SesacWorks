//
//  LoginViewModel.swift
//  CodeBaseUI
//
//  Created by Heedon on 2023/09/18.
//

import Foundation

class LoginViewModel {
    
    var emailText: String?
    var pwText: String?
    var nicknameText: String?
    var locationText: String?
    var promoNum: String?
    
    var resultLabel = Observable("")
    
    func checkValidation() -> Bool {
        
        guard let email = emailText, email.contains("@") else {
            resultLabel.value = "이메일 형식을 맞춰야 합니다 (@ 포함)"
            return false
        }
        
        guard let pw = pwText, pw.count >= 6, pw.count <= 10 else {
            resultLabel.value = "비밀번호는 6~10자리여야 합니다"
            return false
        }
        
        guard let promo = promoNum, promo.count == 6, Int(promo) != nil else {
            resultLabel.value = "추천코드는 6자리 숫자여야 합니다"
            return false
        }
        
        resultLabel.value = "로그인 가능합니다"
        return true
    }
    
}
