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
    
    //Input - Output Pattern
    struct Input {
        let clicked: ControlEvent<Void>
        let text: ControlProperty<String?>
        let selectCell: Observable<(ControlEvent<IndexPath>.Element, ControlEvent<DailyBoxOfficeList>.Element)>
    }
    
    struct Output {
        let resultForTable: Observable<MovieStruct>
        let resultForCollection: Observable<ControlEvent<DailyBoxOfficeList>.Element>
    }
    
    func transform(input: Input) -> Output {
        
        let networkResultData = input.clicked
            //UIControl action & String --> return String
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(input.text.orEmpty) { _, query in
                return query
            }
            .map { text -> String in
                guard let intText = Int(text) else { return "20231106" }
                return String(intText)
            }
            //일정 타이밍 지나서 수행
            .flatMap { Network.fetchDataFromMovieAPI(date: $0) }
        
        let dailyMovieList = input.selectCell
            .map { $0.1 }
        
        return Output(resultForTable: networkResultData, resultForCollection: dailyMovieList)
        
    }
    
}
