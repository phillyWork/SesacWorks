//
//  ListConfigurationObservable.swift
//  PhotoGramRealm
//
//  Created by Heedon on 2023/09/14.
//

import Foundation

class ListConfigurationObservable<T> {

    var listener: ((T) -> ())?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> ()) {
        listener = closure
    }
    
}
