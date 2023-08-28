//
//  TrendMovieCollectionViewCell.swift
//  TMDBCodeBaseNetworkSingleton
//
//  Created by Heedon on 2023/08/28.
//

import UIKit
import Kingfisher

class TrendMovieCollectionViewCell: BaseCollectionViewCell {
    
    //MARK: - Properties
    
    let dateLabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    let genreTagLabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    
    let rateDetailLabel = {
        let label = UILabel()
        label.text = "평점"
        label.textColor = .white
        label.font = .systemFont(ofSize: 11)
        label.backgroundColor = .systemIndigo
        label.textAlignment = .center
        return label
    }()
    
    let ratePointLabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 11)
        label.textAlignment = .center
        label.backgroundColor = .white
        return label
    }()
    
    let titleLabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    let detailLabel = {
        let label = UILabel()
        label.text = "자세히 보기"
        label.textColor = .black
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    let shadowView = {
        let shadow = UIView()
        shadow.backgroundColor = .clear
        shadow.layer.shadowColor = UIColor.black.cgColor
        shadow.layer.shadowOffset = .zero
        shadow.layer.shadowRadius = 10
        shadow.layer.shadowOpacity = 0.5
        return shadow
    }()
    
    let backView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        return view
    }()
    
    let lineView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    let backPathImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let indicatorImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "chevron.right")
        return iv
    }()
    
    var movie: Movie? {
        didSet {
            updateWithData()
        }
    }
    
    
    //MARK: - Setup
    
    override func configViews() {
        super.configViews()
        
        contentView.addSubview(dateLabel)
        contentView.addSubview(genreTagLabel)
        contentView.addSubview(shadowView)
        shadowView.addSubview(backView)
        backView.addSubview(backPathImageView)
        backView.addSubview(rateDetailLabel)
        backView.addSubview(ratePointLabel)
        backView.addSubview(titleLabel)
        backView.addSubview(lineView)
        backView.addSubview(detailLabel)
        backView.addSubview(indicatorImageView)
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        dateLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView).inset(10)
            make.height.equalTo(18)
        }
        
        genreTagLabel.snp.makeConstraints { make in
            make.leading.equalTo(dateLabel.snp.leading)
            make.height.equalTo(21)
            make.top.equalTo(dateLabel.snp.bottom).offset(5)
        }
        
        shadowView.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(contentView).inset(10)
            make.top.equalTo(genreTagLabel.snp.bottom).offset(10)
        }
        
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backPathImageView.snp.makeConstraints { make in
            make.top.equalTo(backView.snp.top)
            make.horizontalEdges.equalTo(backView.snp.horizontalEdges)
            make.height.equalTo(backView.snp.height).multipliedBy(0.65)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(backView.snp.leading).offset(15)
            make.trailing.greaterThanOrEqualTo(backView.snp.trailing).inset(10)
            make.height.equalTo(24)
            make.top.equalTo(backPathImageView.snp.bottom).offset(15)
        }
        
        lineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalTo(backView.snp.trailing).inset(15)
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
        }
        
        detailLabel.snp.makeConstraints { make in
//            make.leading.equalTo(lineView.snp.leading)
            make.leading.equalTo(titleLabel.snp.leading)
            make.bottom.equalTo(backView.snp.bottom).inset(15)
        }
        
        indicatorImageView.snp.makeConstraints { make in
//            make.trailing.equalTo(lineView)
            make.trailing.equalTo(backView.snp.trailing).inset(15)
            make.top.equalTo(detailLabel.snp.top)
            make.size.equalTo(detailLabel.snp.height).multipliedBy(1.267)
        }
        
        rateDetailLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.leading)
            make.width.equalTo(backPathImageView.snp.width).multipliedBy(0.1)
            make.bottom.equalTo(backPathImageView.snp.bottom).offset(-15)
        }
        
        ratePointLabel.snp.makeConstraints { make in
            make.leading.equalTo(rateDetailLabel.snp.trailing)
            make.width.equalTo(rateDetailLabel.snp.width)
            make.top.equalTo(rateDetailLabel.snp.top)
        }
        
    }
    
    func updateWithData() {
        guard let movie = movie else {
            print("No data from datamanager")
            return
        }
        
        dateLabel.text = movie.releaseDate
        
        var genreText = [String]()
        for id in movie.genreIDS {
            if let genreName = GenreIds(rawValue: id)?.genreName {
                genreText.append("#\(genreName) ")
            } else {
                print("Can't find this \(id) from genre")
            }
        }
        
        genreTagLabel.text = genreText.joined()
        
        ratePointLabel.text = "\(round(movie.voteAverage*100)/100)"
        
        titleLabel.text = movie.title
        
        let backUrl = URL(string: ImageUrl.backPath.requestURL + movie.backdropPath)
        backPathImageView.kf.setImage(with: backUrl)
    }
    
    override func prepareForReuse() {
        dateLabel.text = nil
        genreTagLabel.text = nil
        backPathImageView.image = nil
        ratePointLabel.text = nil
        titleLabel.text = nil
    }
}
