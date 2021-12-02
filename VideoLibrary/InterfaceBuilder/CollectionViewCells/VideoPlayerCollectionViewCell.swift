//
//  VideoPlayerCollectionViewCell.swift
//  VideoLibrary
//
//  Created by Manish Kumar on 01/12/21.
//

import UIKit
import AVKit

protocol VideoPlayerCollectionViewCellDelegate {
    func closeButtonPressed()
}

class VideoPlayerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var videoPlayerView: UIView!
    @IBOutlet weak var btnClosePlayer: UIButton!
    
    var delegate: VideoPlayerCollectionViewCellDelegate?
            
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        btnClosePlayer.layer.cornerRadius = 0.5 * btnClosePlayer.bounds.size.width
        btnClosePlayer.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    @IBAction func btnClosePlayerPressed(_ sender: Any) {
        delegate?.closeButtonPressed()
    }
}
