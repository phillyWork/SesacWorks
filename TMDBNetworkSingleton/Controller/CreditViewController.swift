//
//  CreditVC.swift
//  TMDBNetworkSingleton
//
//  Created by Heedon on 2023/08/11.
//

import UIKit

class CreditViewController: UIViewController {

    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
//    @IBOutlet weak var overviewLabel: UILabel!
//    @IBOutlet weak var overviewTextView: UITextView!
//    @IBOutlet weak var castLabel: UILabel!
    @IBOutlet weak var castingTableView: UITableView!
    
    let dataManager = DataManager.shared
    
    var isExpanded = false
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCastData()
    }
    
    func setupCastData() {
        if let movie = movie {
            
            //with decodable
            dataManager.setCastingListWithDecodableStruct(type: .movieCasting, movieId: movie.id) {
                print("Setting up casting list is done")
                self.configUI()
                self.configTableView()
            }
//            dataManager.setCastingList(type: .movieCasting, movieId: movie.movieId) {
//                self.configUI()
//                self.configTableView()
//            }
        } else {
            print("No data from TrendVC")
            return
        }
    }
    
    func configTableView() {
        
        let nib1 = UINib(nibName: CastCell.identifier, bundle: nil)
        let nib2 = UINib(nibName: OverviewCell.identifier, bundle: nil)
        castingTableView.register(nib1, forCellReuseIdentifier: CastCell.identifier)
        castingTableView.register(nib2, forCellReuseIdentifier: OverviewCell.identifier)
        
        castingTableView.delegate = self
        castingTableView.dataSource = self
        
        castingTableView.rowHeight = UITableView.automaticDimension
    }

}

//MARK: - Extension for TableView Delegate, DataSource

extension CreditViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Overview"
        } else {
            return "Cast"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return dataManager.getCastingList().count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = castingTableView.dequeueReusableCell(withIdentifier: OverviewCell.identifier) as! OverviewCell
            if let movie = movie {
                cell.overview = movie.overview
            }
            cell.selectionStyle = .none
            cell.overviewLabel.numberOfLines = isExpanded ? 0 : 2
            return cell
        } else {
            let cell = castingTableView.dequeueReusableCell(withIdentifier: CastCell.identifier) as! CastCell
            cell.cast = dataManager.getCastingList()[indexPath.row]
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            isExpanded.toggle()
            castingTableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
}


//MARK: - Extension for UI

extension CreditViewController {
    
    func configUI() {
        configLabel()
        configImageView()
//        configTextView()
        configData()
    }
    
    func configLabel() {
        
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.textColor = .white
        
//        overviewLabel.text = "OverView"
//        overviewLabel.textColor = .darkGray
//        overviewLabel.font = .systemFont(ofSize: 14)
//
//        castLabel.text = "Cast"
//        castLabel.textColor = .darkGray
//        castLabel.font = .systemFont(ofSize: 14)
    }
    
    func configImageView() {
        backdropImageView.contentMode = .scaleAspectFill
        posterImageView.contentMode = .scaleAspectFill
    }
    
//    func configTextView() {
//        overviewTextView.isEditable = false
//        overviewTextView.textColor = .black
//        overviewTextView.textAlignment = .center
//    }
    
    func configData() {
        guard let movie = movie else {
            print("No movie data from ")
            return
        }
        titleLabel.text = movie.title
//        overviewTextView.text = movie.overview
        
        let backdropUrl = URL(string: ImageURL.backPath.requestURL + movie.backdropPath)
        let posterUrl = URL(string: ImageURL.poster.requestURL + movie.posterPath)
        
        backdropImageView.kf.setImage(with: backdropUrl)
        posterImageView.kf.setImage(with: posterUrl)
    }
}
