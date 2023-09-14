//
//  SearchViewController.swift
//  MovieCollectionViewAssignment
//
//  Created by Heedon on 2023/07/31.
//

import UIKit

class SearchViewController: UIViewController {

    //MARK: - Properties
    let dataManager = DataManager.shared
    
    static let identifier = "SearchViewController"
    
    
    //MARK: - Setup UI
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configSearchNavBar()
    }
    
    func configSearchNavBar() {
        navigationItem.title = "검색 화면"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    
    //MARK: - Handlers
    
    @objc func closeButtonTapped() {
        self.dismiss(animated: true)
    }
    
    
    

   
}
