//
//  SampleViewModel.swift
//  iPadMVVMUnsplashAPI
//
//  Created by Heedon on 2023/09/12.
//

import Foundation

class SampleViewModel {
    
    //VC가 데이터를 가지고 있을 필요 없음
    private var list = [User(name: "Hue", age: 23), User(name: "Jack", age: 21), User(name: "Bran", age: 20), User(name: "Kokojong", age: 20)]

    //필요한 data 가공도 여기서 처리
    var numberOfRowsInSection: Int {
        return list.count
    }
    
    
    func cellForRowAt(at indexPath: IndexPath) -> User {
        return list[indexPath.row]
    }
    
}
