//
//  NumbersViewController.swift
//  RxSampleProjects
//
//  Created by Heedon on 2023/10/31.
//

import UIKit

import RxSwift
import RxCocoa

class NumbersViewController: UIViewController {

    @IBOutlet weak var inputTextFieldOne: UITextField!
    @IBOutlet weak var inputTextFieldTwo: UITextField!
    @IBOutlet weak var inputTextFieldThree: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    let numbersVM = NumbersViewModel()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        completeLastExample()
        
    }

    func completeLastExample() {
        //combineLatest: 원래대로면 들어가는 Observable들이 한번씩 방출하고 나서야 event 방출 시 작업을 하지만
        //UI 한정: nil이 아닌 빈값을 방출하고 시작
        
        //수행하자마자 이미 한번씩 방출하고 시작하므로 textField 변화에 대해 바로 반영해서 작업
        Observable.combineLatest(inputTextFieldOne.rx.text.orEmpty, inputTextFieldTwo.rx.text.orEmpty, inputTextFieldThree.rx.text.orEmpty) { textValue1, textValue2, textValue3 -> Int in
                return (Int(textValue1) ?? 0) + (Int(textValue2) ?? 0) + (Int(textValue3) ?? 0)
            }
            .map { $0.description }
            .bind(to: resultLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    
    
    
}
