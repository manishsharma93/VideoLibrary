//
//  ExploreTableViewCell.swift
//  VideoLibrary
//
//  Created by Manish Kumar on 29/11/21.
//

import UIKit
import AVFoundation

protocol ExploreTableViewCellDelegate {
    func playVideo(selectedIndex: Int, data: [Nodes], frame: CGRect)
}

class ExploreTableViewCell : UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var contentCollectionView: UICollectionView!
    
    var dataArray : [Nodes]?
    
    var delegate: ExploreTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentCollectionView.register(UINib.init(nibName: "GridCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GridCollectionViewCell")
        contentCollectionView.delegate = self
        contentCollectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func getThumbnailImageFromVideoUrl(url: URL, completion: @escaping ((_ image: UIImage?)->Void)) {
        DispatchQueue.global().async { //1
            let asset = AVAsset(url: url) //2
            let avAssetImageGenerator = AVAssetImageGenerator(asset: asset) //3
            avAssetImageGenerator.appliesPreferredTrackTransform = true //4
            let thumnailTime = CMTimeMake(value: 2, timescale: 1) //5
            do {
                let cgThumbImage = try avAssetImageGenerator.copyCGImage(at: thumnailTime, actualTime: nil) //6
                let thumbNailImage = UIImage(cgImage: cgThumbImage) //7
                DispatchQueue.main.async { //8
                    completion(thumbNailImage) //9
                }
            } catch {
                print(error.localizedDescription) //10
                DispatchQueue.main.async {
                    completion(nil) //11
                }
            }
        }
    }
    
}

extension ExploreTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridCollectionViewCell", for: indexPath) as? GridCollectionViewCell

        let data = dataArray?[indexPath.row]
        
        self.getThumbnailImageFromVideoUrl(url: (URL(string: data?.video?.encodeUrl ?? "")!)) { (thumbNailImage) in
            cell?.videoImageView.image = thumbNailImage
        }
        
        return cell!
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 120 , height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridCollectionViewCell", for: indexPath) as? GridCollectionViewCell
        
        delegate?.playVideo(selectedIndex: indexPath.row, data: dataArray ?? [], frame: cell?.frame ?? self.frame)
    }
}

