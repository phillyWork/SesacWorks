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
        scrollView.bounces = false                          //땡겨지는 animation 없애기
        scrollView.showsVerticalScrollIndicator = false     //indicator 숨기기
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.backgroundColor = .white
        contentView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(scrollView)      //scrollView의 frame 영역과 contents 영역 분리 --> device width 크기보다 작게 잡힘
            make.width.equalTo(scrollView.snp.width)    //scrollView의 width와 contentView 동일하게 설정 (width 고정)
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

        label.numberOfLines = 0
        label.text = "ssldks\njdflsdfja\n\n;ldkfjadslkf\nja;lskdfjals\ndkjfas\nlfkajafklssldks\njdflsdfja\n\n;ldkfjadslkf\nja;lskdfjals\ndkjfas\nlfkajafklssldks\njdflsdfja\n\n;ldkfjadslkf\nja;lskdfjals\ndkjfas\nlfkajafklssldks\njdflsdfja\n\n;ldkfjadslkf\nja;lskdfjals\ndkjfas\nlfkajafkl"
        label.backgroundColor = .systemGreen
        label.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalTo(contentView)
            make.top.equalTo(imageView.snp.bottom).offset(50)
            make.bottom.equalTo(button.snp.top).offset(-50)
        }
        
    }
    
    
}
