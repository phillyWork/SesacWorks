//
//  MovieTableViewCell.swift
//  RxSwiftMovieAPI
//
//  Created by Heedon on 2023/11/07.
//

import UIKit

import SnapKit

final class MovieTableViewCell: UITableViewCell {
    
    static let identifier = "MovieTableViewCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .yellow
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .green
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configCell() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(15)
            make.centerY.equalTo(contentView)
            make.width.equalTo(contentView).multipliedBy(0.4)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.trailing.equalTo(contentView).inset(15)
            make.centerY.equalTo(contentView)
            make.width.equalTo(contentView).multipliedBy(0.4)
        }
    }

}
