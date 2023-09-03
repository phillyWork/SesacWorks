//
//  BaseView.swift
//  MultipleCellExample
//
//  Created by Heedon on 2023/09/01.
//

import UIKit
import SnapKit

class BaseView: UIView {

    let manager = SingletonManager.shared
    
    var delegate: ShowAlertInVC?
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.delegate = self
        table.dataSource = self
        table.prefetchDataSource = self
        table.register(MovieCell.self, forCellReuseIdentifier: MovieCell.identifier)
        table.register(TVCell.self, forCellReuseIdentifier: TVCell.identifier)
        table.rowHeight = 120
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        setupData()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupData() {
        manager.callRequest(page: manager.getPageNum()) { result in
            DispatchQueue.main.async {
                result ? self.tableView.reloadData() : print("Failed to Get data")
            }
        }
    }
    
}

//MARK: - Extension for TableView Delegate, DataSource

extension BaseView: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager.getData().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let media = manager.getData()[indexPath.row]
        switch media.mediaType {
        case .movie:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier) as? MovieCell else { return UITableViewCell() }
            cell.media = media
            return cell
        case .tv:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TVCell.identifier) as? TVCell else { return UITableViewCell() }
            cell.media = media
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let media = manager.getData()[indexPath.row]
        let title = media.name != nil ? media.name : media.title
        delegate?.showAlert(title: title!, message: media.overview)
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        for indexPath in indexPaths {
            if indexPath.row == manager.getData().count - 1 {
                manager.addPage()
                manager.callRequest(page: manager.getPageNum()) { result in
                    DispatchQueue.main.async {
                        result ? self.tableView.reloadData() : print("Failed to Get data")
                    }
                }
            }
        }
    }
    
}
