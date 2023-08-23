//
//  VideoCell.swift
//  TMDBSegmentControlDispatchGroup
//
//  Created by Heedon on 2023/08/18.
//

import UIKit
//import AVFoundation

class VideoCell: UICollectionViewCell {

//    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var video: Video? {
        didSet {
            updateWithData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

//        coverImageView.contentMode = .scaleAspectFill
        
        titleLabel.textColor = .black
        titleLabel.font = .boldSystemFont(ofSize: 16)
        
        typeLabel.textColor = .darkGray
        typeLabel.font = .systemFont(ofSize: 13, weight: .medium)
        
        dateLabel.textColor = .darkGray
        dateLabel.font = .systemFont(ofSize: 13, weight: .medium)
    }

    override func prepareForReuse() {
//        coverImageView.image = nil
        titleLabel.text = nil
        typeLabel.text = nil
        dateLabel.text = nil
    }
    
    func updateWithData() {
        guard let video = video else { return }
        
        titleLabel.text = video.name
        typeLabel.text = video.type
        dateLabel.text = video.yyyyMMddReleaseDate
    
//        if let url = URL(string: URL.makeEndPointYoutubeURL(video.key)) {
//            print("Making thumbnail starts")
//            setupThumbnailFromYoutubeURL(url: url)
//        }
    }
    
//    func setupThumbnailFromYoutubeURL(url: URL) {
//        let myAsset = AVAsset(url: url)
//        let imageGenerator = AVAssetImageGenerator(asset: myAsset)
//
//        let firstTime = CMTime(value: 600, timescale: 600)
//        let secondTime = CMTime(value: 1200, timescale: 600)
//
//        let times: [NSValue] = [firstTime as NSValue, secondTime as NSValue]
//
//        imageGenerator.generateCGImagesAsynchronously(forTimes: times) { _, cgImage, _, _, _ in
//            if let cgImage = cgImage {
//                self.coverImageView.image = UIImage(cgImage: cgImage)
//            }
//        }
//    }
    
    
}
