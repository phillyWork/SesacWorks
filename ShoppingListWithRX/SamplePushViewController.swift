//
//  SamplePushViewController.swift
//  ShoppingListWithRX
//
//  Created by Heedon on 2023/11/05.
//

import UIKit

class SamplePushViewController: UIViewController {
    
    var selectedCellDataFromMainVC: String?
            
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        title = selectedCellDataFromMainVC
    }
    
}
