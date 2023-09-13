//
//  Observable.swift
//  CodeBaseUI
//
//  Created by Heedon on 2023/09/12.
//

import Foundation

class Observable<T> {
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
 
    //closure 담기용
    var listener: ((T) -> ())?
    
    //초기화
    init(_ value: T) {
        self.value = value
    }
    
    //closure 할당 (연결)
    func bind(_ closure: @escaping (T) -> ()) {
        listener = closure
    }
    
    
}
