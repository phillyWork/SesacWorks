//
//  ViewController.swift
//  MultipleCellExample
//
//  Created by Heedon on 2023/09/01.
//

import UIKit

class ViewController: UIViewController {

    let baseView = BaseView()
    
    override func loadView() {
        self.view = baseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        baseView.delegate = self
    }

}

//MARK: - Extension for ShowAlertInVC

extension ViewController: ShowAlertInVC {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirm = UIAlertAction(title: "확인", style: .cancel)
        alert.addAction(confirm)
        present(alert, animated: true)
    }
}
