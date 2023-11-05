//
//  FirstViewController.swift
//  TMDBCodeBaseNetworkSingleton
//
//  Created by Heedon on 2023/08/28.
//

import UIKit

class FirstViewController: BaseViewController {

    let label: UILabel = {
        let label = UILabel()
        label.text = "Page Control 시작합니다."
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
