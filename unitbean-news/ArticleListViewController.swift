//
//  ViewController.swift
//  unitbean-news
//
//  Created by darya on 21.04.2020.
//  Copyright © 2020 darya. All rights reserved.
//

import UIKit
import Alamofire
import Reachability

class ArticleListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadMoreButton: UIButton!
    @IBOutlet weak var loadMoreIndicator: UIActivityIndicatorView!
    var isLoadingData : Bool = false
    var articles : [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getArticles()
        let navLabel = UILabel()
        let navTitle = NSMutableAttributedString(string: "UNITBEAN", attributes:[
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: navLabel.font.pointSize)])
        navTitle.append(NSMutableAttributedString(string: ".NEWS", attributes:[
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: navLabel.font.pointSize),
            NSAttributedString.Key.foregroundColor: UIColor.red]))
        navLabel.attributedText = navTitle
        self.navigationItem.titleView = navLabel
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.separatorColor = .clear
    }
    
    func getArticles(){
        isLoadingData = true
        ArticleRequest.instance.getArticleList { (newArticles) in
            DispatchQueue.global().async {
                self.isLoadingData = false
                DispatchQueue.main.async {
                    self.loadMoreIndicator.stopAnimating()
                }
                guard let newArticles = newArticles else {
                    DispatchQueue.main.async {
                        self.errorLoadMore()
                    }
                    return
                }
                let filteredNewArticles = newArticles.filter({ (newArticle) -> Bool in
                    self.articles.first(where: {$0.url == newArticle.url}) == nil
                })
                if !filteredNewArticles.isEmpty {
                    self.articles.append(contentsOf: filteredNewArticles)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    func getNetworkType() -> Reachability.Connection? {
        do{
            let reachability:Reachability = try Reachability()
            do{
                try reachability.startNotifier()
                return reachability.connection
            }catch{
                return nil
            }
        }catch{
            return nil
        }
    }
    
    @IBAction func loadMore(_ sender: UIButton) {
        self.loadMoreButton.isHidden = true
        self.loadMoreIndicator.startAnimating()
        self.getArticles()
    }
    
    func errorLoadMore(){
        if self.loadMoreButton.isHidden {
            self.loadMoreButton.setImage(UIImage(systemName : "goforward"), for: .normal)
            self.loadMoreButton.setAttributedTitle(NSAttributedString(string: "ПОВТОРИТЬ ЗАГРУЗКУ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red]), for: .normal)
            self.loadMoreButton.setTitleColor(UIColor.red, for: .normal)
            self.loadMoreButton.tintColor = .red
            self.loadMoreButton.isHidden = false
            self.loadMoreIndicator.stopAnimating()
        }
    }
}

