//
//  TableViewModel.swift
//  RxSampleProjects
//
//  Created by Heedon on 2023/11/02.
//

import Foundation

import RxSwift

final class TableViewModel {
    
    let tableItems = Observable.just(
        (0..<20).map { "\($0)" }
    )
    
}
