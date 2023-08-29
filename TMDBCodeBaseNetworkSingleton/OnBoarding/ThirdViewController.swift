//
//  ThirdViewController.swift
//  TMDBCodeBaseNetworkSingleton
//
//  Created by Heedon on 2023/08/28.
//

import UIKit

class ThirdViewController: BaseViewController {

    let label: UILabel = {
        let label = UILabel()
        label.text = "Page Control 마지막 page."
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    lazy var startButton: UIButton = {
        let button = UIButton()
        button.setTitle("시작하기", for: .normal)
        button.backgroundColor = .systemPurple
        button.tintColor = .white
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configViews() {
        super.configViews()
        
        view.addSubview(label)
        view.addSubview(startButton)
        
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        label.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(30)
        }
        
        startButton.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(50)
            make.height.equalTo(30)
        }
    }

    
    @objc func startButtonTapped() {
        //rootViewController 변경
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        let trendVC = TrendMovieViewController()
        let nav = UINavigationController(rootViewController: trendVC)
        //SceneDelegate의 window 설정 변경
        sceneDelegate?.window?.rootViewController = nav
        sceneDelegate?.window?.makeKeyAndVisible()
    }
    
    
   

}
