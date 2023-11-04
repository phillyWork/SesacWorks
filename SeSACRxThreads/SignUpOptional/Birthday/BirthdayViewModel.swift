//
//  BirthdayViewModel.swift
//  SeSACRxThreads_For_Assignment
//
//  Created by Heedon on 2023/11/02.
//

import Foundation

import RxSwift
import RxCocoa

final class BirthdayViewModel {
    
    let birthDay: BehaviorSubject<Date> = BehaviorSubject(value: .now)
    
    let year = BehaviorSubject(value: 0)
    let month = BehaviorSubject(value: 0)
    let day = BehaviorSubject(value: 0)
    
    let isOverSeventeen = BehaviorSubject(value: false)
    
    let disposeBag = DisposeBag()
    
    init() {
        //해당 날짜 data에 나누어 전달하기
        birthDay
            .subscribe(with: self) { owner, date in
                let component = Calendar.current.dateComponents([.year, .month, .day], from: date)
                owner.year.onNext(component.year!)
                owner.month.onNext(component.month!)
                owner.day.onNext(component.day!)
            }
            .disposed(by: disposeBag)
        
        //17세 여부 판단
        birthDay
            .map { Calendar.current.dateComponents([.year], from: $0, to: .now) }
            .map { $0.year! >= 17 }
            .subscribe(with: self) { owner, value in
                owner.isOverSeventeen.onNext(value)
            }
            .disposed(by: disposeBag)
    }
    
}
