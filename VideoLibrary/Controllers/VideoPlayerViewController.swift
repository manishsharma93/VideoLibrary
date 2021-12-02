//
//  VideoPlayerViewController.swift
//  VideoLibrary
//
//  Created by Manish Kumar on 29/11/21.
//

import UIKit
import AVKit

class VideoPlayerViewController: UIViewController, VideoPlayerCollectionViewCellDelegate {
    
    var nodeData: [Nodes]?
    var selectedIndex: Int?
    
    @IBOutlet weak var videoCollectionView: UICollectionView!
    
    var player: AVPlayer = AVPlayer()
    var playerLayer: AVPlayerLayer = AVPlayerLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = true

        //Registering cells with CollectionView
        videoCollectionView.register(UINib.init(nibName: "VideoPlayerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "VideoPlayerCollectionViewCell")
        
        videoCollectionView.delegate = self
        videoCollectionView.dataSource = self

        //Scrolling Collection View to the selected Item path
        videoCollectionView.scrollToItem(at: IndexPath(row: selectedIndex ?? 0, section: 0), at: .top, animated: true)
        
        //Observer for Player ends playing video
        NotificationCenter.default.addObserver(self, selector: #selector(playerEndPlay), name: .AVPlayerItemDidPlayToEndTime, object: nil)
        
        //Playing the selected video
        playVideo(index: selectedIndex ?? 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func closeButtonPressed() {
        stopPlayingVideo()
        
        self.navigationController?.popViewController(animated: true)
        //        dismiss(animated: true, completion: nil)
    }
    
    @objc func playerEndPlay() {
        stopPlayingVideo()
        
        playVideo(index: selectedIndex ?? 0)
        
        videoCollectionView.reloadItems(at: [IndexPath(row: selectedIndex ?? 0, section: 0)])
    }
    
    func playVideo(index: Int) {
        
        let item = AVPlayerItem(url: URL(string: nodeData?[index].video?.encodeUrl ?? "")!)

        self.player = AVPlayer(playerItem: item)
        self.player.play()
        
        self.player.actionAtItemEnd = .none
    }
    
    func stopPlayingVideo() {
        if player.currentItem != nil {
            player.pause()
            player.replaceCurrentItem(with: nil)
        }
    }
}

extension VideoPlayerViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nodeData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoPlayerCollectionViewCell", for: indexPath) as? VideoPlayerCollectionViewCell
        
        cell?.delegate = self
        
        self.playerLayer = AVPlayerLayer(player: self.player)
        self.playerLayer.videoGravity = .resizeAspectFill
        self.playerLayer.frame = UIScreen.main.bounds
        
        cell?.videoPlayerView.layer.addSublayer(self.playerLayer)
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width , height: collectionView.bounds.height)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if targetContentOffset.pointee.y < scrollView.contentOffset.y {
            if selectedIndex != 0 {
                selectedIndex = (selectedIndex ?? 0) - 1
            }
        } else {
            if selectedIndex != ((nodeData?.count ?? 0) - 1) {
                selectedIndex = (selectedIndex ?? 0) + 1
            }
        }
        
        //This will stop and play the next/previous video depending upon the Index value
        playerEndPlay()
    }
    
}
