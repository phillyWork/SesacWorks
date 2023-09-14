//
//  BaseViewController.swift
//  PhotoGramRealm
//
//  Created by jack on 2023/09/03.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setConstraints()
    }
    
    func configure() {
        view.backgroundColor = Constants.BaseColor.background
    }
    
    func setConstraints() {}
    
    
    //alert 빈도높게 활용하는 경우
    func showAlertMessage(title: String, button: String = "확인", handler: (() -> ())? = nil ) { //매개변수 기본값
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: button, style: .default) { _ in
            handler?()
        }
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
}
