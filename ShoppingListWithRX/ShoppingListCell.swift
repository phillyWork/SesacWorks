//
//  ShoppingListCell.swift
//  ShoppingListWithRX
//
//  Created by Heedon on 2023/11/05.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

final class ShoppingListCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    let todoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11, weight: .medium)
        label.textColor = .black
        return label
    }()
    
    lazy var checkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    lazy var starButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    var disposeBag = DisposeBag()
    
    //MARK: - Setup
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        disposeBag = DisposeBag()
    }
    
    private func configCell() {
        contentView.backgroundColor = .lightGray
        contentView.addSubview(checkButton)
        contentView.addSubview(todoLabel)
        contentView.addSubview(starButton)
        
        checkButton.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(contentView.snp.leading).offset(15)
            make.height.equalTo(contentView).multipliedBy(0.3)
            make.width.equalTo(checkButton.snp.height)
        }

        starButton.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.trailing.equalTo(contentView.snp.trailing).inset(15)
            make.size.equalTo(checkButton)
        }

        todoLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(checkButton.snp.trailing).offset(25)
            make.trailing.equalTo(starButton.snp.leading).inset(25)
        }
    }
    
    func toggleCheck() {
        if checkButton.imageView?.image == UIImage(systemName: "checkmark.square") {
            setSelectedCheck()
        } else {
            setDeselectedCheck()
        }
    }
    
    private func setSelectedCheck() {
        checkButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
    }
    
    private func setDeselectedCheck() {
        checkButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
    }
    
    func toggleStar() {
        if starButton.imageView?.image == UIImage(systemName: "star") {
            setSelectedStar()
        } else {
            setDeselectedStar()
        }
    }
    
    private func setSelectedStar() {
        starButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
    }
    
    private func setDeselectedStar() {
        starButton.setImage(UIImage(systemName: "star"), for: .normal)
    }
    
}
