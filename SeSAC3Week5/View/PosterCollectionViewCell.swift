//
//  PosterCollectionViewCell.swift
//  SeSAC3Week5
//
//  Created by Heedon on 2023/08/16.
//

import UIKit

class PosterCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    
    //정적 design 한번 설정 계속 사용
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    //재사용시 준비해야할 사항
    override func prepareForReuse() {
        super.prepareForReuse()
        
        //이전 data 삭제 or sample image로 설정해놓기
        posterImageView.image = nil
    }
    
}
