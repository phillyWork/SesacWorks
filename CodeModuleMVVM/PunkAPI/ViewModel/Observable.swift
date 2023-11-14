//
//  Observable.swift
//  CodeModuleMVVM
//
//  Created by Heedon on 2023/09/19.
//

import Foundation

class Observable<T> {

    var listener: ((T) -> ())?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void ) {
        listener = closure
    }
    
}
