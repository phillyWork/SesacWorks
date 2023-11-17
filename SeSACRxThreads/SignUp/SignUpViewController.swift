//
//  SignUpViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

class SignUpViewController: UIViewController {

    enum ExampleError: Error {
        case invalid
    }
    
    let emailTextField = SignTextField(placeholderText: "이메일을 입력해주세요")
    let validationButton = UIButton()
    let nextButton = PointButton(title: "다음")
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Color.white
        
        configureLayout()
        configure()
        
        nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)

        disposeExample()
//        incrementExample()
//        publishSubject()
//        behaviorSubject()
//        replaySubject()
//        asyncSubject()
    }
    
    deinit {
        print("deinit")
    }
    
    func disposeExample() {
        let textArray = BehaviorSubject(value: ["A", "B", "C"])
        
        let textArrayValue = textArray.subscribe(with: self) { owner, value in
            print("next - \(value)")
        } onError: { owner, error in
            print("error - \(error)")
        } onCompleted: { owner in
            print("Completed")
        } onDisposed: { owner in
            print("disposed")
        }
        
        textArray.onNext(["D", "E", "F"])
        textArray.onError(ExampleError.invalid)
        textArray.onNext(["X", "Y", "Z"])
        
        //직접 해제하기
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            textArrayValue.dispose()
        }
    }
    
    func incrementExample() {
        let increment = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
        increment
            .subscribe(with: self) { owner, value in
                print("next - \(value)")
            } onError: { owner, error in
                print("error - \(error)")
            } onCompleted: { owner in
                print("Completed")
            } onDisposed: { owner in
                print("disposed")
            }
            .disposed(by: disposeBag)
    }
    
    func publishSubject() {
        let publish = PublishSubject<Int>()
        
        publish.onNext(20)
        publish.onNext(30)
        
        publish
            .subscribe(with: self) { owner, value in
                print("PublishSubject - \(value)")
            } onError: { owner, error in
                print("PublishSubject - \(error)")
            } onCompleted: { owner in
                print("PublishSubject completed")
            } onDisposed: { owner in
                print("PublishSubject disposed")
            }
            .disposed(by: disposeBag)
        
        
        //subscribe 이후부터 처리
        publish.on(.next(3))
        publish.onNext(4)
        publish.onNext(9)
        
        publish.onCompleted()
        
        //completed 이후 더 이상 event 처리하지 않음
        publish.onNext(6)
        publish.onNext(7)
        
    }
    
    func behaviorSubject() {
        let behavior = BehaviorSubject(value: 200)
        
        behavior.onNext(20)
        behavior.onNext(30)
        
        //subscribe 시, 마지막 전달된 event 방출
        behavior
            .subscribe(with: self) { owner, value in
                print("BehaviorSubject - \(value)")
            } onError: { owner, error in
                print("BehaviorSubject - \(error)")
            } onCompleted: { owner in
                print("BehaviorSubject completed")
            } onDisposed: { owner in
                print("BehaviorSubject disposed")
            }
            .disposed(by: disposeBag)
        
        behavior.on(.next(3))
        behavior.onNext(4)
        behavior.onNext(9)
        
        behavior.onCompleted()
        
        //completed 이후 더 이상 event 처리하지 않음
        behavior.onNext(6)
        behavior.onNext(7)
        
    }
    
    func replaySubject() {
        //buffer size만큼 event 담았다가 subscribe 시, 방출
        let replay = ReplaySubject<Int>.create(bufferSize: 3)
        
        replay.onNext(-10)
        replay.onNext(0)
        replay.onNext(10)
        replay.onNext(29)
        replay.onNext(37)
        
        replay
            .subscribe(with: self) { owner, value in
                print("ReplaySubject - \(value)")
            } onError: { owner, error in
                print("ReplaySubject - \(error)")
            } onCompleted: { owner in
                print("ReplaySubject completed")
            } onDisposed: { owner in
                print("ReplaySubject disposed")
            }
            .disposed(by: disposeBag)
        
        replay.onNext(3)
        replay.onNext(4)
        replay.on(.next(9))
        
        //completed 이후 더 이상 event 처리하지 않음
        replay.onCompleted()
        
        replay.onNext(6)
        replay.onNext(7)
        
    }
    
    func asyncSubject() {
        let async = AsyncSubject<Int>()
        
        async.onNext(-10)
        async.onNext(0)
        async.onNext(10)
        async.onNext(29)
        async.onNext(37)
        
        async
            .subscribe(with: self) { owner, value in
                print("AsyncSubject - \(value)")
            } onError: { owner, error in
                print("AsyncSubject - \(error)")
            } onCompleted: { owner in
                print("AsyncSubject completed")
            } onDisposed: { owner in
                print("AsyncSubject disposed")
            }
            .disposed(by: disposeBag)
        
        
        async.onNext(3)
        async.onNext(4)
        async.on(.next(9))
        
        //completed 만나기까지 가장 최근 event 담고있다가 completed 만나면 해당 event 방출
        
        //completed 이후 더 이상 event 처리하지 않음
        async.onCompleted()
        
        async.onNext(6)
        async.onNext(7)
    }
    
    
    @objc func nextButtonClicked() {
        navigationController?.pushViewController(PasswordViewController(), animated: true)
    }

    func configure() {
        validationButton.setTitle("중복확인", for: .normal)
        validationButton.setTitleColor(Color.black, for: .normal)
        validationButton.layer.borderWidth = 1
        validationButton.layer.borderColor = Color.black.cgColor
        validationButton.layer.cornerRadius = 10
    }
    
    func configureLayout() {
        view.addSubview(emailTextField)
        view.addSubview(validationButton)
        view.addSubview(nextButton)
        
        validationButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.width.equalTo(100)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.trailing.equalTo(validationButton.snp.leading).offset(-8)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(emailTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    

}
