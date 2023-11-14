//
//  SubTItleViewController.swift
//  PhotoGram
//
//  Created by Heedon on 2023/08/29.
//

import UIKit

class SubTitleViewController: BaseViewController {
    
    let subTitleView = SubTitleView()
    
    var completionHandler: ((String) -> ())?
    
    override func loadView() {
        self.view = subTitleView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if let text = subTitleView.textView.text {
            completionHandler?(text)
        }
    }
    
    override func configViews() {
        super.configViews()
    }
    
    override func setConstraints() {
        super.setConstraints()
    }
    
}
