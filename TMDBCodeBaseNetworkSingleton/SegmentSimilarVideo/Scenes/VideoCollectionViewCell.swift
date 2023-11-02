//
//  VideoCollectionViewCell.swift
//  TMDBCodeBaseNetworkSingleton
//
//  Created by Heedon on 2023/09/04.
//

import UIKit

class VideoCollectionViewCell: BaseCollectionViewCell {
    
    //MARK: - Properties
    
    var video: Video? {
        didSet {
            updateWithData()
        }
    }
    
    let titleLabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    let typeLabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 13, weight: .medium)
        return label
    }()
    
    let dateLabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 13, weight: .medium)
        return label
    }()
    
    override func configViews() {
        super.configViews()
        backgroundColor = .lightGray
        addSubview(titleLabel)
        addSubview(typeLabel)
        addSubview(dateLabel)
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        titleLabel.snp.makeConstraints { make in
            make.top.directionalHorizontalEdges.equalTo(self.safeAreaLayoutGuide).offset(10)
        }
        
        typeLabel.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalTo(titleLabel)
            make.top.equalTo(typeLabel.snp.bottom).offset(10)
        }
    }
    
    private func updateWithData() {
        guard let video = video else { return }
        
        titleLabel.text = video.name
        typeLabel.text = video.type
        dateLabel.text = video.yyyyMMddReleaseDate
    }
    
    override func prepareForReuse() {
        titleLabel.text = nil
        typeLabel.text = nil
        dateLabel.text = nil
    }
    
}
