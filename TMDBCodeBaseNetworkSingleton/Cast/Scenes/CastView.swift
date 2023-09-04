//
//  CastView.swift
//  TMDBCodeBaseNetworkSingleton
//
//  Created by Heedon on 2023/08/28.
//

import UIKit

class CastView: BaseView {
    
    let backdropImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    
    let posterImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(OverviewTableViewCell.self, forCellReuseIdentifier: OverviewTableViewCell.identifier)
        table.register(CastTableViewCell.self, forCellReuseIdentifier: CastTableViewCell.identifier)
        return table
    }()
    
    override func configViews() {
        super.configViews()
        
        addSubview(backdropImageView)
        addSubview(titleLabel)
        addSubview(posterImageView)
        addSubview(tableView)
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        backdropImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(self.safeAreaLayoutGuide).multipliedBy(0.3)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(backdropImageView.snp.bottom)
            make.bottom.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(self.safeAreaLayoutGuide).offset(30)
        }
        
        posterImageView.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.leading)
            make.bottom.equalTo(backdropImageView.snp.bottom)
            make.height.equalTo(backdropImageView.snp.height).multipliedBy(0.7)
            make.width.equalTo(posterImageView.snp.height).multipliedBy(0.625)
        }
        
    }
    
}
