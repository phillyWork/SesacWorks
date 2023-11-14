//
//  FirstViewController.swift
//  TMDBNetworkSingleton
//
//  Created by Heedon on 2023/08/25.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var explanationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemCyan
        explanationLabel.text = "Page Control 시작합니다."
        explanationLabel.textAlignment = .center
        explanationLabel.textColor = .white
        explanationLabel.font = .boldSystemFont(ofSize: 20)
    }

}
