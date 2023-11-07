//
//  SimpleCollectionViewModel.swift
//  iPadMVVMUnsplashAPI
//
//  Created by Heedon on 2023/09/18.
//

import Foundation

class SimpleCollectionViewModel {
    
    //UUID 활용 ~ instance 생성 때 알아서 생성 --> 구분 가능
    let list: Observable<[User]> = Observable( [ ] )
    
    let list2 = [User(name: "Jack", age: 23),
                        User(name: "Jack", age: 23),
                        User(name: "Bran", age: 20),
                        User(name: "Kokojong", age: 20)
    ]
    
    //정의: 빈 배열
    //메서드로 data 추가하기
    func append() {
        list.value = [User(name: "Hue", age: 23),
                      User(name: "Hue", age: 23),
//                        User(name: "Jack", age: 21),
                      User(name: "Bran", age: 20),
                      User(name: "Kokojong", age: 20)
        ]
    }
    
    
    //신규 데이터 추가하기
    func insertUser(name: String) {
        let user = User(name: name, age: Int.random(in: 10...70))
        list.value.insert(user, at: Int.random(in: 0...2))
    }
    
    
    //배열 한번에 지우는 기능
    func remove() {
        list.value = []
    }
    
    
    func removeUser(indexPath: IndexPath) {
        list.value.remove(at: indexPath.item)
    }
    
    
}
