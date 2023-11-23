//
//  PhotoListTableViewCell.swift
//  PhotoGramRealm
//
//  Created by jack on 2023/09/03.
//

import UIKit
import SnapKit

final class PhotoListTableViewCell: BaseTableViewCell {
    
    let diaryImageView: PhotoImageView = {
        let view = PhotoImageView(frame: .zero)
        return view
    }()
    
    let titleLabel: UILabel = {
       let view = UILabel()
        view.textColor = Constants.BaseColor.text
        view.font = .boldSystemFont(ofSize: 15)
        return view
    }()
    
    let dateLabel: UILabel = {
       let view = UILabel()
        view.textColor = Constants.BaseColor.text
        view.font = .boldSystemFont(ofSize: 13)
        return view
    }()
    
    let contentLabel: UILabel = {
       let view = UILabel()
        view.textColor = Constants.BaseColor.text
        view.font = .systemFont(ofSize: 13)
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [titleLabel, dateLabel, contentLabel])
        view.axis = .vertical
        view.alignment = .top
        view.distribution = .fillEqually
        view.spacing = 2
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        

    }
    
    override func prepareForReuse() {
        diaryImageView.image = nil
    }

    
    override func configure() {
        
        selectionStyle = .none
        backgroundColor = Constants.BaseColor.background
        
        [diaryImageView, stackView].forEach {
            contentView.addSubview($0)
        }
         
        [titleLabel, dateLabel, contentLabel].forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    override func setConstraints() {
        let spacing = 8
        
        diaryImageView.snp.makeConstraints { make in
            make.height.equalTo(contentView).inset(spacing)
            make.width.equalTo(diaryImageView.snp.height)
            make.centerY.equalTo(contentView)
            make.trailingMargin.equalTo(-spacing)
        }
        
        stackView.snp.makeConstraints { make in
            make.leadingMargin.top.equalTo(spacing)
            make.bottom.equalTo(-spacing)
            make.trailing.equalTo(diaryImageView.snp.leading).offset(-spacing)
        }
    }
    

    
    
}
