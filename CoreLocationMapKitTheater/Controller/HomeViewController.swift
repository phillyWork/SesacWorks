//
//  HomeViewController.swift
//  CoreLocationMapKitTheater
//
//  Created by Heedon on 2023/08/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    lazy var pushButton: UIButton = {
        let button = UIButton()
        button.layer.borderColor = UIColor.systemMint.cgColor
        button.layer.borderWidth = 3
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemOrange
        button.setTitle("지도 보기", for: .normal)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        
        button.addTarget(self, action: #selector(pushButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
            
        configButton()
    }
    
    func configButton() {
        
        view.addSubview(pushButton)

        pushButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pushButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pushButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            pushButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5),
            pushButton.heightAnchor.constraint(equalTo: pushButton.widthAnchor, multiplier: 0.5)
        ])
        
    }
    
    @objc func pushButtonTapped() {
        let nav = UINavigationController(rootViewController: TheaterViewController())
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }

}
