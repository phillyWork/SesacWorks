//
//  CalculateObservable.swift
//  iPadMVVMUnsplashAPI
//
//  Created by Heedon on 2023/09/13.
//

import Foundation

//MARK: - Observable 이해하기: 왜 필요한지, 직접 data 가져다 쓰는 것보다

//어떤 type이 들어와도 상관 없도록 하기: Generic
//Class 이름 변경: Person --> CalculateObservable
class CalculateObservable<T> {
    
    //introduce의 매개변수를 여기에 담기
//    var luckyNumber: Int?
    
    //함수 타입으로 introduce의 closure 담기
    private var listener: ((T) -> Void)?
    
    //property 이름 수정: name --> value
    var value: T {
        //해당 property 값 변화마다 감지, block 내 코드 실행
        //introduce 메서드의 매개변수도 같이 활용하고 싶음: scope 때문에 바로 전달 불가능
        //해결: 변수 만들어서 변수에 update하기 --> 가져다 활용 가능
        
        //이름 변경: backgroundColor 바꾸고 싶음
        //해결: 함수를 변수로 만들어서 대입, didSet에서 실행하기 (luckyNumber처럼)
        didSet {
//            print("사용자의 이름이 \(oldValue)에서 \(name)으로 변경되었습니다. 당신이 뽑은 행운의 숫자는 \(luckyNumber ?? 0)입니다.")
            print("사용자의 이름이 \(oldValue)에서 \(value)으로 변경되었습니다.")
            
            //closure 담은 listener 실행하기
            //optioanl이므로 chaining으로 처리
            //name을 밖에서(VC) 활용하도록 받아서 closure 실행
            listener?(value)
            
        }
    }
    
    //외부 매개변수 생략해서 사용하기
    init(_ name: T) {
        self.value = name
    }
    
    //기능 추가

    //random 대신 매개변수 활용하기
    //외부 매개변수 생략해서 사용하기
    
    
//    func introduce(_ number: Int, sample: @escaping () -> Void) {
//        print("저는 \(name)이고 행운의 숫자는 \(Int.random(in: 1...10))입니다.")
    
    //매개변수로 closure만 받기
    //name을 전달하기
    
    //메서드 명 변경: introduce --> bind (유연하게 활용하기)
    func bind(_ sample: @escaping (T) -> Void) {
//        print("저는 \(name)이고 행운의 숫자는 \(number)입니다.")
        print("저는 \(value)입니다.")

        //매개변수로 들어온 sample 함수의 기능을 실행
        //sample: view.backgroundColor 변경 코드
        //매개변수로 name을 전달
        
        //introduce 수행 중일때 closure 실행하고 싶지 않다면 주석 처리 (상황따라 다 다름)
        sample(value)
        
        //매개변수 담기
//        luckyNumber = number
        
        
        //매개변수에 closure인 sample 담기
        //closure가 함수 밖에서 존재하기: introduce가 끝나고 난 이후에도 ~ @escaping 필요
        
        //closure를 listener에 할당해주지 않으면 이후 name property의 값 변화해도 didSet에서 listener 실행할 수 없음
        listener = sample
    }
    
}
