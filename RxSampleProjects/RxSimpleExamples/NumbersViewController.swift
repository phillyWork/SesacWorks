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
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        completeLastExample()
        
    }

    func completeLastExample() {
        Observable.combineLatest(inputTextFieldOne.rx.text.orEmpty, inputTextFieldTwo.rx.text.orEmpty, inputTextFieldThree.rx.text.orEmpty) { textValue1, textValue2, textValue3 -> Int in
                return (Int(textValue1) ?? 0) + (Int(textValue2) ?? 0) + (Int(textValue3) ?? 0)
            }
            .map { $0.description }
            .bind(to: resultLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    
    
    
}
