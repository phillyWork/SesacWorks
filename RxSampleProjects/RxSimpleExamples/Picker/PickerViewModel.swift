//
//  PickerViewModel.swift
//  RxSampleProjects
//
//  Created by Heedon on 2023/11/02.
//

import Foundation

import RxSwift

final class PickerViewModel {
    
    let pickerViewJustSource = Observable.just([1, 2, 3])
    let pickerViewOfSource = Observable.of([1, 2, 3], [4, 5, 6])
    let pickerViewFromSource = Observable.from(optional: [1, 2, 3])
    
}
