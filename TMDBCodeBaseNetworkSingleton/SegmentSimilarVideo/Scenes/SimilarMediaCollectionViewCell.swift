//
//  SegmentCollectionViewCell.swift
//  TMDBCodeBaseNetworkSingleton
//
//  Created by Heedon on 2023/08/29.
//

import UIKit

class SimilarMediaCollectionViewCell: BaseCollectionViewCell {
    
    //MARK: - Properties
    
    var media: Similar? {
        didSet {
            updateWithData()
        }
    }
    
    let coverImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 10
        return iv
    }()
    
    let titleLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    let dateRateLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .darkGray
        return label
    }()
    
    let overviewLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    
    //MARK: - Setup
    
    override func configViews() {
        super.configViews()
        addSubview(coverImageView)
        addSubview(titleLabel)
        addSubview(dateRateLabel)
        addSubview(overviewLabel)
    }
    
    override func setConstraints() {
        super.setConstraints()
        coverImageView.snp.makeConstraints { make in
            make.leading.centerY.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(self.safeAreaLayoutGuide).multipliedBy(0.9)
            make.width.equalTo(coverImageView.snp.height).multipliedBy(0.5625)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(coverImageView.snp.top)
            make.leading.equalTo(coverImageView.snp.trailing).offset(15)
            make.height.equalTo(coverImageView.snp.height).multipliedBy(0.15)
            make.trailing.lessThanOrEqualTo(self.safeAreaLayoutGuide).inset(5)
        }
        
        dateRateLabel.snp.makeConstraints { make in
            make.leading.height.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.trailing.lessThanOrEqualTo(self.safeAreaLayoutGuide).inset(5)
        }
        
        overviewLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel)
            make.top.equalTo(dateRateLabel.snp.bottom).offset(10)
            make.trailing.lessThanOrEqualTo(self.safeAreaLayoutGuide).inset(5)
            make.bottom.lessThanOrEqualTo(coverImageView.snp.bottom)
        }
    }
    
    private func updateWithData() {
        guard let media = media else { return }
        
        dateRateLabel.text = media.dateRate
        titleLabel.text = media.cellTitle
        overviewLabel.text = media.overview
        
        guard let posterPath = media.posterPath else { return }
        
        if let posterUrl = URL(string: ImageUrl.posterPath.requestURL + posterPath) {
            DispatchQueue.global().async {
                do {
                    let imageData = try Data(contentsOf: posterUrl)
                    DispatchQueue.main.async {
                        self.coverImageView.image = UIImage(data: imageData)
                    }
                } catch {
                    print(error)
                }
            }
        }
        
    }
    
    override func prepareForReuse() {
        coverImageView.image = nil
        titleLabel.text = nil
        dateRateLabel.text = nil
        overviewLabel.text = nil
    }
    
}
