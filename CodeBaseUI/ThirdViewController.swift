//
//  ThirdViewController.swift
//  CodeBaseUI
//
//  Created by Heedon on 2023/08/22.
//

import UIKit
import SnapKit

class ThirdViewController: UIViewController {

    //MARK: - Properties
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.text = "10월 24일 09시 42분"
        label.backgroundColor = .blue
        return label
    }()
    
    let locationImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "location.fill")
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .blue
        iv.tintColor = .white
        return iv
    }()
    
    let reloadButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.counterclockwise"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .blue
        return button
    }()
    
    let shareButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .blue
        return button
    }()
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.text = "서울, 신림동"
        label.backgroundColor = .blue
        return label
    }()
    
    let chatLabelOne: PaddingLabel = {
        let label = PaddingLabel()
        label.text = "지금은 9도에요"
        label.textColor = .black
        label.backgroundColor = .white
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        return label
    }()
    
    let chatLabelTwo: PaddingLabel = {
        let label = PaddingLabel()
        label.text = "78%만큼 습해요"
        label.textColor = .black
        label.backgroundColor = .white
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        return label
    }()
    
    let chatLabelThree: PaddingLabel = {
        let label = PaddingLabel()
        label.text = "1m/s의 바람이 불어요"
        label.textColor = .black
        label.backgroundColor = .white
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        return label
    }()
    
    let chatImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
//        iv.contentMode = .scaleAspectFill
//        iv.image = UIImage(systemName: "cloud.fill")
        iv.image = UIImage(named: "swiftBanner6")
        iv.backgroundColor = .blue
        return iv
    }()
    
    let chatLabelFour: PaddingLabel = {
        let label = PaddingLabel()
        label.text = "오늘도 행복한 하루 보내세요"
        label.textColor = .black
        label.backgroundColor = .white
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        return label
    }()
    
    //MARK: - Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemOrange
        
        let components = [dateLabel, locationImageView, reloadButton, shareButton, locationLabel, chatLabelOne, chatLabelTwo, chatLabelThree, chatImageView, chatLabelFour]
        
        for component in components {
            view.addSubview(component)
        }
        
        configConstraints()
    }
    
    
    func configConstraints() {
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.width.equalToSuperview().multipliedBy(0.35)
        }
        
        locationImageView.snp.makeConstraints { make in
            make.leading.equalTo(dateLabel.snp.leading)
            make.top.equalTo(dateLabel.snp.bottom).offset(15)
            make.width.equalTo(dateLabel.snp.width).multipliedBy(0.3)
            make.height.equalTo(locationImageView.snp.width)
        }
        
        reloadButton.snp.makeConstraints { make in
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.centerY.equalTo(locationImageView.snp.centerY)
            make.size.equalTo(locationImageView.snp.size).multipliedBy(0.9)
        }
        
        shareButton.snp.makeConstraints { make in
            make.trailing.equalTo(reloadButton.snp.leading).offset(-20)
            make.centerY.equalTo(locationImageView.snp.centerY)
            make.size.equalTo(reloadButton.snp.size)
        }
        
        locationLabel.snp.makeConstraints { make in
            make.centerY.equalTo(locationImageView.snp.centerY)
            make.leading.equalTo(locationImageView.snp.trailing).offset(15)
            make.trailing.equalTo(shareButton.snp.leading).offset(-15)
            make.height.equalTo(locationImageView.snp.height)
        }
        
        chatLabelOne.snp.makeConstraints { make in
            make.leading.equalTo(dateLabel.snp.leading)
            make.top.equalTo(locationImageView.snp.bottom).offset(15)
            make.height.equalTo(locationImageView.snp.height)
            make.trailing.lessThanOrEqualTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        chatLabelTwo.snp.makeConstraints { make in
            make.leading.equalTo(dateLabel.snp.leading)
            make.top.equalTo(chatLabelOne.snp.bottom).offset(15)
            make.height.equalTo(chatLabelOne.snp.height)
            make.trailing.lessThanOrEqualTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        chatLabelThree.snp.makeConstraints { make in
            make.leading.equalTo(dateLabel.snp.leading)
            make.top.equalTo(chatLabelTwo.snp.bottom).offset(15)
            make.height.equalTo(chatLabelOne.snp.height)
            make.trailing.lessThanOrEqualTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        chatImageView.snp.makeConstraints { make in
            make.leading.equalTo(dateLabel.snp.leading)
            make.top.equalTo(chatLabelThree.snp.bottom).offset(15)
            make.height.lessThanOrEqualToSuperview().multipliedBy(0.20)
            make.width.equalTo(chatImageView.snp.height).multipliedBy(1.2)
//            make.trailing.lessThanOrEqualTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        chatLabelFour.snp.makeConstraints { make in
            make.leading.equalTo(dateLabel.snp.leading)
            make.top.equalTo(chatImageView.snp.bottom).offset(15)
            make.height.equalTo(chatLabelOne.snp.height)
            make.trailing.lessThanOrEqualTo(view.safeAreaLayoutGuide).inset(20)
        }
        
    }
    
}
