//
//  BirthdayViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//
 
import UIKit

import SnapKit
import RxSwift
import RxCocoa

class BirthdayViewController: UIViewController {
    
    let birthDayPicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        picker.locale = Locale(identifier: "ko-KR")
        picker.maximumDate = Date()
        return picker
    }()
    
    let infoLabel: UILabel = {
       let label = UILabel()
        label.textColor = Color.black
        label.text = "만 17세 이상만 가입 가능합니다."
        return label
    }()
    
    let containerStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.spacing = 10 
        return stack
    }()
    
    let yearLabel: UILabel = {
       let label = UILabel()
        label.text = "2023년"
        label.textColor = Color.black
        label.snp.makeConstraints {
            $0.width.equalTo(100)
        }
        return label
    }()
    
    let monthLabel: UILabel = {
       let label = UILabel()
        label.text = "33월"
        label.textColor = Color.black
        label.snp.makeConstraints {
            $0.width.equalTo(100)
        }
        return label
    }()
    
    let dayLabel: UILabel = {
       let label = UILabel()
        label.text = "99일"
        label.textColor = Color.black
        label.snp.makeConstraints {
            $0.width.equalTo(100)
        }
        return label
    }()
  
    let nextButton = PointButton(title: "가입하기")
    
    //pickerView에 설정한 값: label로 전달하기
    let birthDay: BehaviorSubject<Date> = BehaviorSubject(value: .now)
    
    let year = BehaviorSubject(value: 0)
    let month = BehaviorSubject(value: 0)
    let day = BehaviorSubject(value: 0)
    
    let isOverSeventeen = BehaviorSubject(value: false)
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Color.white
        
        bind()
        
        configureLayout()
        
        nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
    }
    
    func bind() {
        
        //UI 결정값 --> data update하기
        birthDayPicker.rx.date
            .bind(to: birthDay)
            .disposed(by: disposeBag)
        
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
        
        isOverSeventeen
            .bind(to: nextButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        isOverSeventeen
            .map { $0 ? "가입 허가 대상입니다." : "만 17세 이상만 가입 가능합니다." }
            .bind(to: infoLabel.rx.text)
            .disposed(by: disposeBag)
        
        //각 날짜 data는 label에 전달 as String
        //UI update: main thread 보장 필요
        year
            .observe(on: MainScheduler.instance)
            .map { "\($0)년" }
            .subscribe(with: self) { owner, year in
                self.yearLabel.text = year
            }
            .disposed(by: disposeBag)
        
        month
            .observe(on: MainScheduler.instance)
            .map { "\($0)월" }
            .subscribe(with: self) { owner, month in
                self.monthLabel.text = month
            }
            .disposed(by: disposeBag)
        
        day
            .observe(on: MainScheduler.instance)
            .map { "\($0)일" }
            .bind(to: dayLabel.rx.text)
            .disposed(by: disposeBag)
        
    }
    
    @objc func nextButtonClicked() {
        print("가입완료")
    }

    
    func configureLayout() {
        view.addSubview(infoLabel)
        view.addSubview(containerStackView)
        view.addSubview(birthDayPicker)
        view.addSubview(nextButton)
 
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(150)
            $0.centerX.equalToSuperview()
        }
        
        containerStackView.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
        }
        
        [yearLabel, monthLabel, dayLabel].forEach {
            containerStackView.addArrangedSubview($0)
        }
        
        birthDayPicker.snp.makeConstraints {
            $0.top.equalTo(containerStackView.snp.bottom)
            $0.centerX.equalToSuperview()
        }
   
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(birthDayPicker.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }

}
