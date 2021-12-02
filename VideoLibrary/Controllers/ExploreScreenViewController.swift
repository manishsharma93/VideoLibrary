//
//  ExploreScreenViewController.swift
//  VideoLibrary
//
//  Created by Manish Kumar on 29/11/21.
//

import UIKit

class ExploreScreenViewController: UIViewController, ExploreTableViewCellDelegate {
    
    @IBOutlet weak var exploreScreenTableView: UITableView!

    var exploreDataArray: [ResponseData]? = []
    
    var selectedCellFrame : CGRect?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "Explore Screen"
        
        exploreScreenTableView.separatorStyle = .none

        //Registering TableView cells
        registerCells()
        
        //Load Data
        loadJson()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func registerCells() {
        exploreScreenTableView.register(UINib(nibName: "ExploreTableViewCell", bundle: nil), forCellReuseIdentifier: "ExploreTableViewCell")
    }
    
    func loadJson()  {
        if let url = Bundle.main.url(forResource: "assignment", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                
                //Using Codable/Decodable Protocol
                let jsonDecoder = JSONDecoder()
                
                //Parsing data
                let responseModel = try jsonDecoder.decode(ExploreResponse.self, from: data)
                
                exploreDataArray = responseModel.data
            } catch {
                print("error:\(error)")
            }
        }
    }
    
    func playVideo(selectedIndex: Int, data: [Nodes], frame: CGRect) {

        let videoPlayerVC = self.storyboard?.instantiateViewController(withIdentifier: "VideoPlayerViewController") as! VideoPlayerViewController
        
        videoPlayerVC.selectedIndex = selectedIndex
        videoPlayerVC.nodeData = data
        
        self.navigationController?.pushViewController(videoPlayerVC, animated: true)
//        present(videoPlayerVC, animated: true, completion: nil)
    }
}


extension ExploreScreenViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exploreDataArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExploreTableViewCell", for: indexPath) as! ExploreTableViewCell
        
        let data = exploreDataArray?[indexPath.row]
        
        cell.titleLabel.text = data?.title ?? ""
        cell.dataArray = data?.nodes
        cell.delegate = self

        cell.selectionStyle = .none
        
        return cell
    }
}

extension ExploreScreenViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animator = PresentAnimator()
        animator.originFrame = selectedCellFrame ?? self.view.frame
        return animator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animator = DismissAnimator()
        return animator
    }
}
