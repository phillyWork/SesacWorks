//
//  OverviewCell.swift
//  TMDBNetworkSingleton
//
//  Created by Heedon on 2023/08/25.
//

import UIKit

class OverviewCell: UITableViewCell {

    @IBOutlet weak var overviewLabel: UILabel!
    
    var overview: String? {
        didSet {
            updateOverview()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configLabel()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func configLabel() {
        overviewLabel.textColor = .black
        overviewLabel.font = .systemFont(ofSize: 13, weight: .medium)
        overviewLabel.textAlignment = .center
    }
    
    private func updateOverview() {
        guard let overview = overview else { return }
        overviewLabel.text = overview
    }
    
}
