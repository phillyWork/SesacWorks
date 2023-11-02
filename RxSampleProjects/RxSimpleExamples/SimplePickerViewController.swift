//
//  ViewController.swift
//  RxSampleProjects
//
//  Created by Heedon on 2023/10/31.
//

import UIKit

import RxSwift
import RxCocoa

class SimplePickerViewController: UIViewController {

    @IBOutlet weak var pickerViewOne: UIPickerView!
    @IBOutlet weak var pickerViewTwo: UIPickerView!
    @IBOutlet weak var pickerViewThree: UIPickerView!
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
//        operatorJustExample()
//        operatorOfExample()
        operatorFromExample()
    }

    func operatorJustExample() {
        Observable.just([1, 2, 3])
            .bind(to: pickerViewOne.rx.itemTitles) { _, item in
                return "\(item)"
            }
            .disposed(by: disposeBag)

        pickerViewOne.rx.modelSelected(Int.self)
            .subscribe(onNext: { models in
                print("models selected 1: \(models)")
            })
            .disposed(by: disposeBag)
        
        Observable.just([1, 2, 3])
            .bind(to: pickerViewTwo.rx.itemAttributedTitles) { _, item in
                return NSAttributedString(string: "\(item)",
                                          attributes: [
                                            NSAttributedString.Key.foregroundColor: UIColor.cyan,
                                            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.double.rawValue
                                        ])
            }
            .disposed(by: disposeBag)

        pickerViewTwo.rx.modelSelected(Int.self)
            .subscribe(onNext: { models in
                print("models selected 2: \(models)")
            })
            .disposed(by: disposeBag)
        
        Observable.just([UIColor.red, UIColor.green, UIColor.blue])
            .bind(to: pickerViewThree.rx.items) { _, item, _ in
                let view = UIView()
                view.backgroundColor = item
                return view
            }
            .disposed(by: disposeBag)

        pickerViewThree.rx.modelSelected(UIColor.self)
            .subscribe(onNext: { models in
                print("models selected 3: \(models)")
            })
            .disposed(by: disposeBag)
    }
    
    
    func operatorOfExample() {
        Observable.of([1, 2, 3], [4, 5, 6])
            .bind(to: pickerViewOne.rx.itemTitles) { _, item in
                return "\(item)"
            }
            .disposed(by: disposeBag)

        pickerViewOne.rx.modelSelected(Int.self)
            .subscribe(onNext: { models in
                print("models selected 1: \(models)")
            })
            .disposed(by: disposeBag)
        
        Observable.of([1, 2, 3], [4, 5, 6])
            .bind(to: pickerViewTwo.rx.itemAttributedTitles) { _, item in
                return NSAttributedString(string: "\(item)",
                                          attributes: [
                                            NSAttributedString.Key.foregroundColor: UIColor.cyan,
                                            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.double.rawValue
                                        ])
            }
            .disposed(by: disposeBag)

        pickerViewTwo.rx.modelSelected(Int.self)
            .subscribe(onNext: { models in
                print("models selected 2: \(models)")
            })
            .disposed(by: disposeBag)
        
        Observable.of([UIColor.red, UIColor.green, UIColor.blue], [UIColor.magenta, UIColor.orange, UIColor.cyan])
            .bind(to: pickerViewThree.rx.items) { _, item, _ in
                let view = UIView()
                view.backgroundColor = item
                return view
            }
            .disposed(by: disposeBag)

        pickerViewThree.rx.modelSelected(UIColor.self)
            .subscribe(onNext: { models in
                print("models selected 3: \(models)")
            })
            .disposed(by: disposeBag)
        
    }
    
    
    func operatorFromExample() {
        Observable.from(optional: [1, 2, 3])
            .bind(to: pickerViewOne.rx.itemTitles) { _, item in
                return "\(item)"
            }
            .disposed(by: disposeBag)

        pickerViewOne.rx.modelSelected(Int.self)
            .subscribe(onNext: { models in
                print("models selected 1: \(models)")
            })
            .disposed(by: disposeBag)
        
        Observable.from(optional: [1, 2, 3])
            .bind(to: pickerViewTwo.rx.itemAttributedTitles) { _, item in
                return NSAttributedString(string: "\(item)",
                                          attributes: [
                                            NSAttributedString.Key.foregroundColor: UIColor.cyan,
                                            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.double.rawValue
                                        ])
            }
            .disposed(by: disposeBag)

        pickerViewTwo.rx.modelSelected(Int.self)
            .subscribe(onNext: { models in
                print("models selected 2: \(models)")
            })
            .disposed(by: disposeBag)
        
        Observable.from(optional: [UIColor.red, UIColor.green, UIColor.blue])
            .bind(to: pickerViewThree.rx.items) { _, item, _ in
                let view = UIView()
                view.backgroundColor = item
                return view
            }
            .disposed(by: disposeBag)

        pickerViewThree.rx.modelSelected(UIColor.self)
            .subscribe(onNext: { models in
                print("models selected 3: \(models)")
            })
            .disposed(by: disposeBag)
        
    }
    

}

