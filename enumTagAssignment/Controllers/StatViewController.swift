//
//  StatViewController.swift
//  enumTagAssignment
//
//  Created by Heedon on 2023/07/25.
//

import UIKit

class StatViewController: UIViewController {

    //MARK: - Properties
    
    let dataManager = DataManager.shared
    
    @IBOutlet var backgroundViews: [UIView]!
    
    @IBOutlet var happyLabel: UILabel!
    @IBOutlet var smileLabel: UILabel!
    @IBOutlet var sosoLabel: UILabel!
    @IBOutlet var sadLabel: UILabel!
    @IBOutlet var tearLabel: UILabel!
    
    
    //MARK: - Setup UI
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configTapData()
    }
    
    func configUI() {
        configBackgroundViews()
        configLabels()
    }

    func configBackgroundViews() {
        for view in backgroundViews {
            view.layer.cornerRadius = 10
            view.clipsToBounds = true
        }
    }
    
    func configLabels() {
        happyLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        smileLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        sosoLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        sadLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        tearLabel.font = .systemFont(ofSize: 20, weight: .semibold)
    }
    
    func configTapData() {
        let data = dataManager.getData()
        
//        happyLabel.text = "\(data[0])회"
//        smileLabel.text = "\(data[1])회"
//        sosoLabel.text = "\(data[2])회"
//        sadLabel.text = "\(data[3])회"
//        tearLabel.text = "\(data[4])회"
        
        //Dict 아직 초기화 안된 경우 고려
        happyLabel.text = "\(data[Emotion.happy.name] ?? 0)회"
        smileLabel.text = "\(data[Emotion.smile.name] ?? 0)회"
        sosoLabel.text = "\(data[Emotion.soso.name] ?? 0)회"
        sadLabel.text = "\(data[Emotion.sad.name] ?? 0)회"
        tearLabel.text = "\(data[Emotion.tear.name] ?? 0)회"
    }
    

}
