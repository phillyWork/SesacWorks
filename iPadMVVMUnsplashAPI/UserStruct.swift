//
//  UserStruct.swift
//  iPadMVVMUnsplashAPI
//
//  Created by Heedon on 2023/09/15.
//

import Foundation

//struct: 값 타입 --> 복사해도 주소값 다 다름 --> instance 생성, 복사: 다 다른 고유값 가짐

//유저 정보
struct User: Hashable { //고유함 보장하기 위해 protocol 채택
    let name: String
    let age: Int
    
    //초기화 때, 다른 값 주면 다른 data로 인지
    //문제: 매번 새로운 id값을 줌 ~ 값 트래킹 어려움
    //Int.random을 무한? 겹칠 가능성 존재함
//    let uniqueId: Int
    
    //해결: uuid 활용 & 초기화 바로 하기
    //instance 생성마다 uniqueId는 고유한 String 자동으로 생성됨
    let uniqueId = UUID().uuidString
    
    //연산 프로퍼티로 data 가공 나타내기
    //호출될 때 메모리 올라옴
    var intorduce: String {
        return "\(name), \(age)살"
    }
    
}



//class: 참조 타입 --> 같은 메모리 주소 가리킬 수 있는 가능성 존재
//class: initializer 설정 필요
//class: Equatable protocol 채택 필요 (구조체처럼 사용하기 목적)

//대부분의 모델: struct로 구성함
class User2: Hashable {
    
    //Equatable protocol 채택 목적
    //어떤 기준으로 동일한지 판단
    static func == (lhs: User2, rhs: User2) -> Bool {
        //lhs: left hands side
        //UUID로 생성한 id 비교하기
        lhs.uniqueId == rhs.uniqueId
    }

    //Hashable protocol 채택 목적
    func hash(into hasher: inout Hasher) {
        hasher.combine(uniqueId)
    }
        
    //고유함 보장하기 위해 protocol 채택
    let name: String
    let age: Int
    
    let uniqueId = UUID().uuidString
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    //연산 프로퍼티로 data 가공 나타내기
    //호출될 때 메모리 올라옴
    var intorduce: String {
        return "\(name), \(age)살"
    }
    
}
