//
//  UserDefaultHelper.swift
//  NetworkingProj
//
//  Created by Heedon on 2023/08/11.
//

import Foundation

class UserDefaultHelper {
    
    //type property로 instance 1개만 생성, 모든 VC에서 동일 instance 접근
    //singleton pattern
    static let standard = UserDefaultHelper()
    
    //singleton pattern처럼 instance 1개만 만들 것
    //각 VC에서 initialization되면 안됨
    //init을 private으로 만들어서 외부에서 초기화 코드 접근 못하도록 접근제어자 설정
    private init() {}
    

    let userDefault = UserDefaults.standard
    
    //key 관리: 열거형
    enum Key: String {      //활용 범위 scope 설정: 내부에서만 사용할 거면 내부에 정의 --> compile 최적화
        case nickname, age
    }
    
    var nickname: String {
        get {
            return userDefault.string(forKey: Key.nickname.rawValue) ?? "대장"
        }
        set {
            //새로운 값 newValue 저장하기
            userDefault.set(newValue, forKey: Key.nickname.rawValue)
        }
    }
    
    var age: Int {
        get {
            return userDefault.integer(forKey: Key.age.rawValue)
        }
        set {
            userDefault.set(newValue, forKey: Key.age.rawValue)
        }
    }
    
    
}
