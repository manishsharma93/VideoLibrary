//
//  GridCollectionView.swift
//  VideoLibrary
//
//  Created by Manish Kumar on 30/11/21.
//

import UIKit

class GridCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var videoImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        videoImageView.layer.cornerRadius = 16.0
        videoImageView.layer.masksToBounds = true

    }

}
