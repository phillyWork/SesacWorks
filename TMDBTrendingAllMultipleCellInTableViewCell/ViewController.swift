//
//  ViewController.swift
//  TMDBTrendingAllMultipleCellInTableViewCell
//
//  Created by Heedon on 2023/09/03.
//

import UIKit

class ViewController: UIViewController {

    let tableView = TableView()
    
    override func loadView() {
        self.view = tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        tableView.delegate = self
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

