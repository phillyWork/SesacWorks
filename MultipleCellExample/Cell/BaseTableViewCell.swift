//
//  BaseTableViewCell.swift
//  MultipleCellExample
//
//  Created by Heedon on 2023/09/03.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    let posterImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    let titleNameLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    
    let rateLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.textColor = .white
        label.backgroundColor = .red
        label.textAlignment = .center
        return label
    }()
    
    var media: Trend? {
        didSet {
            updateData()
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .white
        self.selectionStyle = .none
        
        configViews()
        setConstsraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        posterImageView.image = nil
        titleNameLabel.text = nil
        rateLabel.text = nil
    }
    
    func configViews() {
        addSubview(posterImageView)
        addSubview(titleNameLabel)
        addSubview(rateLabel)
    }
    
    func setConstsraints() {
        posterImageView.snp.makeConstraints { make in
            make.top.bottom.leading.equalTo(self.safeAreaLayoutGuide).inset(10)
            make.width.equalTo(posterImageView.snp.height).multipliedBy(0.6)
        }
        
        titleNameLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.top)
            make.leading.equalTo(posterImageView.snp.trailing).offset(20)
            make.trailing.lessThanOrEqualTo(self.safeAreaLayoutGuide).inset(10)
        }
        
        rateLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleNameLabel.snp.leading)
            make.top.equalTo(titleNameLabel.snp.bottom).offset(15)
            make.trailing.lessThanOrEqualTo(self.safeAreaLayoutGuide).inset(10)
        }
    }
    
    private func updateData() {
        guard let media = media else { return }
        
        titleNameLabel.text = media.name != nil ? media.name : media.title
        rateLabel.text = "\(media.rating)"
        
        guard let url = URL(string: "https://image.tmdb.org/t/p/w342/" + media.posterPath) else {
            print("No Image URL!")
            return
        }
        
        DispatchQueue.global().async {
            do {
                let result = try Data(contentsOf: url)
                DispatchQueue.main.async {
                    self.posterImageView.image = UIImage(data: result)
                }
            } catch {
                print("Image from network failed: ", error.localizedDescription)
            }
        }

    }
    
}
