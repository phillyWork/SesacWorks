//
//  ViewModel.swift
//  RxSwiftMovieAPI
//
//  Created by Heedon on 2023/11/07.
//

import Foundation

import RxSwift
import RxCocoa

final class ViewModel {
    
    let placeholderForSearchBar = Observable.just("검색할 날짜를 입력해주세요")
    
    //API 호출 이후 데이터 전달 받기
    var dataForTable = PublishSubject<[DailyBoxOfficeList]>()
    
    var dataForCollection = BehaviorRelay<[DailyBoxOfficeList]>(value: [])
    
    
    
}
