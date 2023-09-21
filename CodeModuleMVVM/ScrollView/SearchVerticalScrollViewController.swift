//
//  SearchScrollViewController.swift
//  CodeModuleMVVM
//
//  Created by Heedon on 2023/09/21.
//

import UIKit
import SnapKit

class SearchVerticalScrollViewController: UIViewController {
    
    //MARK: - Properties
    
    //세로 scroll
    //scrollView 내 stackView 내 contents
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    //contents 영역
    let imageView = UIImageView()
    let label = UILabel()
    let button = UIButton()
    
    
    //MARK: - Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureHierarchy()
        configureLayout()
        configureContentsView()
    }
    
    func configureHierarchy() {
        view.addSubview(scrollView)
        
        //scrollView 내 UIView 보유
        //UIView 내 각 component 등록, layout 설정
        scrollView.addSubview(contentView)
    }
    
    func configureLayout() {
        
        scrollView.backgroundColor = .lightGray
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
        }
        
    }
    
    func configureContentsView() {
        contentView.addSubview(imageView)
        contentView.addSubview(button)
        contentView.addSubview(label)
        
        imageView.backgroundColor = .orange
        imageView.snp.makeConstraints { make in
            make.top.directionalHorizontalEdges.equalTo(contentView).inset(10)
            make.height.equalTo(200)    //multiplier로 설정 okay
        }

        button.backgroundColor = .systemMint
        button.snp.makeConstraints { make in
            make.bottom.directionalHorizontalEdges.equalTo(contentView).inset(10)
            make.height.equalTo(80)     //multiplier로 설정 okay
        }

        label.text = "ssldksjdflsdfja;ldkfjadslkfja;lskdfjalsdkjfaslfkajafkl"
        label.backgroundColor = .systemGreen
        label.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalTo(contentView)
            make.top.equalTo(imageView.snp.bottom).offset(50)
            make.bottom.equalTo(button.snp.top).offset(-50)
        }
        
    }
    
    
}
