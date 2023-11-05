//
//  RandomPhotoViewController.swift
//  iPadMVVMUnsplashAPI
//
//  Created by Heedon on 2023/09/18.
//

import UIKit
import SnapKit

class RandomPhotoViewController: UIViewController {

    let viewModel = RandomPhotoViewModel()
    
    lazy var apiButton: UIButton = {
        let button = UIButton()
        
        var config = UIButton.Configuration.plain()
        
        var title = AttributedString.init("Random Photo 요청하기")
        title.font = .boldSystemFont(ofSize: 25)
        title.backgroundColor = .orange
        title.foregroundColor = .black
        
        config.attributedTitle = title
        config.titleAlignment = .center
        
        button.configuration = config
        
        button.addTarget(self, action: #selector(apiButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    let randomImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configViews()
        
        bindData()
        
    }
    
    func bindData() {
        viewModel.randomPhoto.bind { randomPhoto in
            //get image from url
            self.viewModel.getPhotoWithURL(url: randomPhoto?.urls.regular)
        }
        
        viewModel.imageFromURL.bind { image in
            //show image into imageView
            self.randomImageView.image = image
        }
    }
    
    
    @objc func apiButtonTapped() {
        viewModel.callRequest()
    }
    
    
    func configViews() {
        view.backgroundColor = .white
        
        view.addSubview(randomImageView)
        view.addSubview(apiButton)
        
        randomImageView.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide)
            make.size.equalTo(250)
        }
        
        apiButton.snp.makeConstraints { make in
            make.top.equalTo(randomImageView.snp.bottom).offset(20)
            make.height.equalTo(100)
            make.directionalHorizontalEdges.equalTo(view.safeAreaLayoutGuide).offset(10)
        }
    }
  
}
