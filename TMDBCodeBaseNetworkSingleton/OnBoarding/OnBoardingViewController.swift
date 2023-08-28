//
//  OnBoardingViewController.swift
//  TMDBCodeBaseNetworkSingleton
//
//  Created by Heedon on 2023/08/28.
//

import UIKit

class OnBoardingViewController: UIPageViewController {

    let vcList: [UIViewController] = [FirstViewController(), SecondViewController(), ThirdViewController()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        configVC()
    }
    
    func configVC() {
        
    }

  

}
