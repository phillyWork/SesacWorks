//
//  CreditViewController.swift
//  TMDBCodeBaseNetworkSingleton
//
//  Created by Heedon on 2023/08/28.
//

import UIKit

class CastViewController: BaseViewController {

    let dataManager = DataManager.shared
    
    let castView = CastView()
    
    var trendMedia: Trend?
    
    var isOverviewExpanded = false
    
    override func loadView() {
        self.view = castView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configViews() {
        super.configViews()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(moreBarButtonTapped))
        
        castView.tableView.delegate = self
        castView.tableView.dataSource = self
        
        guard let media = trendMedia else {
            print("can't get media data from TrendVC")
            return
        }
        
        if let backUrl = URL(string: ImageUrl.backPath.requestURL + media.backdropPath), let posterUrl = URL(string: ImageUrl.posterPath.requestURL + media.posterPath) {
            DispatchQueue.global().async {
                do {
                    let backImageData = try Data(contentsOf: backUrl)
                    let posterImageData = try Data(contentsOf: posterUrl)
                    DispatchQueue.main.async {
                        self.castView.backdropImageView.image = UIImage(data: backImageData)
                        self.castView.posterImageView.image = UIImage(data: posterImageData)
                    }
                } catch {
                    print(error)
                }
            }
        }
        
        if let name = media.name {
            castView.titleLabel.text = name
        } else {
            castView.titleLabel.text = media.title
        }
        
        getCastingAPIWithData()
    }
    
    override func setConstraints() {
        super.setConstraints()
    }
    
    private func getCastingAPIWithData() {
        guard let media = trendMedia else { return }
        switch media.mediaType {
        case .movie:
            dataManager.setupCastingList(type: .movieCasting, movieId: media.id, seriesId: nil) {
                self.castView.tableView.reloadData()
            }
        case .tv:
            dataManager.setupCastingList(type: .tvCasting, movieId: nil, seriesId: media.id) {
                self.castView.tableView.reloadData()
            }
        }
    }
    
    @objc func moreBarButtonTapped() {
        print(#function)
        guard let media = trendMedia else { return }
        let segmentVC = SegmentViewController()
        segmentVC.media = media
        navigationController?.pushViewController(segmentVC, animated: true)
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
            cell.overviewLabel.text = trendMedia?.overview
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
