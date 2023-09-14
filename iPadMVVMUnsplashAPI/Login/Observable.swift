//
//  Observable.swift
//  iPadMVVMUnsplashAPI
//
//  Created by Heedon on 2023/09/12.
//

import Foundation

//어떤 타입도 받아서 변경 적용되도록 함: Generic 활용
class Observable<T> {
    
    //1. property: 선언 & 초기화
    //Observable class의 instance 생성 O, property 접근
//    var value = "고래밥"
    
    
    
    //3. data 변경: 기능 실행하기 (함수 만들기)
    //e.g.) 데이터 통신, 화면 전환, alert 띄우기 등등...
    //closure를 담고, closure 실행하기
//    private var listener: (String) -> Void = { nickname in
//        print("listener", nickname)
//    }
    
    
    //5. 직접 구현할 필요 없음, 밖에서 온 closure 할당받음
    private var listener: ((T) -> Void)?

    
    
    //2. 선언만 해두기
    //init 필요
    
    //model의 값 변경마다 인지하고 싶음
    //property observer 활용
    var value: T {
        didSet {
//            print("didSet", value)
            //3. 바뀐 value를 closure에 전달해서 실행하기
//            listener(value)
            
            listener?(value)
        }
    }
    
    
    //value 매개변수 숨기기
    init(_ value: T) {
        self.value = value
    }
    
    
    //변경된 nickname을 label에 update하기 등 여러 기능 구현하고 싶음
    //4. Observable class 안에서 구현: UIKit 필요 및 model 목적 위배
    //함수 기능을 밖에서 전달받기
    func bind(_ closure: @escaping (T) -> Void ) {
        print(#function)
        
        //파라미터로 closure 전달받음
        //동일 type
        
        //받은 closure를 실행 & listener에 넣기
        
        //listener: 더 이상 구현 필요 없음, 전달만 받으면 됨
        closure(value)
        listener = closure
        
    }
    
    
    
    
    
    
}
