//
//  CreditViewController.swift
//  TMDBCodeBaseNetworkSingleton
//
//  Created by Heedon on 2023/08/28.
//

import UIKit
import Kingfisher

class CastViewController: BaseViewController {

    let dataManager = DataManager.shared
    
    let castView = CastView()
    
    var movie: Movie?
    
    var isOverviewExpanded = false
    
    override func loadView() {
        self.view = castView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCastingAPIWithData()
    }
    
    override func configViews() {
        super.configViews()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(moreBarButtonTapped))
        
        castView.tableView.delegate = self
        castView.tableView.dataSource = self
        
        guard let movie = movie else { return }
        let backUrl = URL(string: ImageUrl.backPath.requestURL + movie.backdropPath)
        castView.backdropImageView.kf.setImage(with: backUrl)
        
        let posterUrl = URL(string: ImageUrl.posterPath.requestURL + movie.posterPath)
        castView.posterImageView.kf.setImage(with: posterUrl)
        
        castView.titleLabel.text = movie.title
    }
    
    override func setConstraints() {
        super.setConstraints()
    }
    
    private func getCastingAPIWithData() {
        guard let movie = movie else { return }
        
        dataManager.setupCastingList(type: .movieCasting, movieId: movie.id) {
            self.castView.tableView.reloadData()
        }
    }
    
    @objc func moreBarButtonTapped() {
        let segmentVC = SegmentControlViewController()
        dataManager.updateMovieID(newMovieId: movie!.id)
    }
    
}


//MARK: - Extension for TableView Delegate, DataSource

extension CastViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return dataManager.getCastingList().count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Overview"
        } else {
            return "Casting"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = castView.tableView.dequeueReusableCell(withIdentifier: OverviewTableViewCell.identifier) as? OverviewTableViewCell else { return UITableViewCell() }
            cell.overviewLabel.text = movie?.overview
            cell.overviewLabel.numberOfLines = isOverviewExpanded ? 0 : 2
            return cell
        } else {
            guard let cell = castView.tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.identifier) as? CastTableViewCell else { return UITableViewCell() }
            cell.cast = dataManager.getCastingList()[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            isOverviewExpanded.toggle()
            castView.tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableView.automaticDimension
        } else {
            return 120
        }
    }
    
}
