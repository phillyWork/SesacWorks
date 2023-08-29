//
//  BaseViewController.swift
//  TMDBCodeBaseNetworkSingleton
//
//  Created by Heedon on 2023/08/28.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configViews()
        setConstraints()
    }
    
    func configViews() {
        view.backgroundColor = .white
        print("Base configViews")
    }
    
    func setConstraints() {
        print("Base setConstraints")
    }

}
