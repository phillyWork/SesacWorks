//
//  Observable.swift
//  BeerAndLotteryAPI
//
//  Created by Heedon on 2023/09/13.
//

import Foundation

//Generic으로 어떤 타입도 다 받기
class Observable<T> {
    
    //실제 값 접근
    var value: T {
        //값 변화 시 실행할 코드 블럭
        didSet {
            //update된 값으로 closure 실행
            listener?(value)
        }
    }
    
    //값 변화 시 실행할 코드 as Closure
    private var listener: ((T) -> ())?
    
    init(_ value: T) {
        self.value = value
    }
    
    //listener에게 할당할 closure 받기
    //bind 함수 종료 이후에도 closure가 listener에게 존재: @escaping 활용
    //VC의 UI component에서 유저 상호작용으로 data 변경 시, value의 didSet에서 할당받은 listener 실행
    func bind(_ closure: @escaping (T) -> ()) {
        listener = closure
    }
    
    
}
