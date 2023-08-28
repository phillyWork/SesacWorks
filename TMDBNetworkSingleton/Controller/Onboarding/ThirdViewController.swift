//
//  ThirdViewController.swift
//  TMDBNetworkSingleton
//
//  Created by Heedon on 2023/08/25.
//

import UIKit

class ThirdViewController: UIViewController {

    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemMint
        
        startLabel.text = "TMDB Trending Movie 보기"
        startLabel.textAlignment = .center
        startLabel.font = .boldSystemFont(ofSize: 20)
        startLabel.textColor = .white
        
        startButton.setTitle("시작하기", for: .normal)
        startButton.backgroundColor = .systemPurple
        startButton.tintColor = .white
    }
    

    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        
        //rootViewController 변경
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let trendVC = sb.instantiateViewController(withIdentifier: TrendViewController.identifier) as! TrendViewController
        
        let nav = UINavigationController(rootViewController: trendVC)
    
        //SceneDelegate의 window 설정 변경
        sceneDelegate?.window?.rootViewController = nav
        sceneDelegate?.window?.makeKeyAndVisible()
    }
    
}
