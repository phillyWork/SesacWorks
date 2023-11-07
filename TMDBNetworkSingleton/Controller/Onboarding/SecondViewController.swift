//
//  SecondViewController.swift
//  TMDBNetworkSingleton
//
//  Created by Heedon on 2023/08/25.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var pageExplanationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemTeal
        
        pageExplanationLabel.text = "리팩토링 어렵다"
        pageExplanationLabel.font = .boldSystemFont(ofSize: 20)
        pageExplanationLabel.textColor = .white
        pageExplanationLabel.textAlignment = .center
        
    }
    

   

}
