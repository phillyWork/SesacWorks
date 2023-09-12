//
//  SecondViewController.swift
//  TMDBCodeBaseNetworkSingleton
//
//  Created by Heedon on 2023/08/28.
//

import UIKit

class SecondViewController: BaseViewController {

    let label: UILabel = {
        let label = UILabel()
        label.text = "Page Control 2번째 page."
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func configViews() {
        super.configViews()
        
        view.addSubview(label)
    }

    override func setConstraints() {
        super.setConstraints()
        
        label.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(30)
        }
    }

}
