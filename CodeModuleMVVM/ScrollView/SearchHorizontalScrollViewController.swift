//
//  SearchVerticalScrollViewController.swift
//  CodeModuleMVVM
//
//  Created by Heedon on 2023/09/21.
//

import UIKit
import SnapKit

class SearchHorizontalScrollViewController: UIViewController {
    
    //MARK: - Properties
    
    //가로 한 줄 스크롤 목적
    //scrollView 내 stackView 내 contents
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    
    //MARK: - Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureHierarchy()
        configureLayout()
        configureStackView()
    }
    
    func configureHierarchy() {
        view.addSubview(scrollView)
        
        //scrollView 내 stackView 보유
        scrollView.addSubview(stackView)
    }
    
    func configureLayout() {
        
        scrollView.backgroundColor = .lightGray
        scrollView.snp.makeConstraints { make in
            make.top.directionalHorizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(70)
        }
        
        stackView.spacing = 15
        stackView.backgroundColor = .orange
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            
            //가로 scroll: content layout과 frame layout height 동일
            make.height.equalTo(70)
        }
        
    }
    
    //stackView 내 contents 설정
    func configureStackView() {
        
        for i in 1...5 {
            let label = UILabel()
            label.text = "안녕하세요 \(i)번째 label입니다."
            label.textColor = .white
            label.backgroundColor = .systemMint
            label.layer.cornerRadius = 10
            label.clipsToBounds = true
            
            //추가한 순서대로 더하기
            stackView.addArrangedSubview(label)
        }
        
        
        
    }
    
}
