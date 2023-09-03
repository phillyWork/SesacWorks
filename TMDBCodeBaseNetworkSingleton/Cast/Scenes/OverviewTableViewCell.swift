//
//  OverviewTableCell.swift
//  TMDBCodeBaseNetworkSingleton
//
//  Created by Heedon on 2023/08/29.
//

import UIKit

class OverviewTableViewCell: BaseTableViewCell {
    
    let overviewLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 13, weight: .medium)
        return label
    }()
    
    override func configViews() {
        super.configViews()
        
        addSubview(overviewLabel)
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        overviewLabel.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
}
