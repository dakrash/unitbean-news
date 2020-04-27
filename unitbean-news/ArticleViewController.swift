//
//  DetailsViewController.swift
//  unitbean-news
//
//  Created by darya on 24.04.2020.
//  Copyright © 2020 darya. All rights reserved.
//

import UIKit

class ArticleViewController : UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var reloadButton: UIButton!
    @IBOutlet weak var imageActivityIndicator: UIActivityIndicatorView!
    var article : Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let article = self.article else {return}
        titleLabel.text = article.title
        date.text = article.date.getString()
        author.text = article.tag
        loadImage()
        loadArticle()
    }
    
    @IBAction func reloadData(_ sender: Any) {
        self.reloadButton.isHidden = true
        self.activityIndicator.startAnimating()
        loadImage()
        loadArticle()
    }
    
    private func loadImage(){
        guard let article = self.article else {return}
        if let image = article.image {
            self.imageActivityIndicator.stopAnimating()
            imageView.setImage(myImage: image)
        } else {
            Data.loadImage(url: article.imageUrl, afterLoad: {image in
                if let image = image {
                    self.imageActivityIndicator.stopAnimating()
                    article.image = image
                    self.imageView.setImage(myImage: image)
                }
            })
        }
    }
    
    private func loadArticle(){
        guard let article = self.article else {return}
        ArticleRequest.instance.getArticle(url: article.url) { articleDetails in
            DispatchQueue.global().async {
                guard let articleDetails = articleDetails else {
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                        self.reloadButton.isHidden = false
                    }
                    return
                }
                var html = articleDetails.htmlBody
                var parts = [String]()
                var imgRangeStart : Range<String.Index>? {html.range(of: "<img")}
                while let imgRangeStart = imgRangeStart {
                    let imgStartIndex = imgRangeStart.lowerBound
                    parts.append(String(html[html.startIndex..<imgStartIndex]))
                    let substr = html[imgStartIndex..<html.endIndex]
                    guard let imgEndIndex = substr.range(of: ">")?.lowerBound else {return}
                    html = String(html[html.index(after: imgEndIndex)..<html.endIndex])
                }
                if !html.isEmpty {
                    parts.append(html)
                }
                DispatchQueue.main.async {
                    var addedViews = [UIView]()
                    for (index, part) in parts.enumerated() {
                        let partLabel = UILabel()
                        partLabel.numberOfLines = 0
                        self.scrollView.addSubview(partLabel)
                        partLabel.translatesAutoresizingMaskIntoConstraints = false
                        NSLayoutConstraint.activate([
                            partLabel.leadingAnchor.constraint(equalTo: self.scrollView.layoutMarginsGuide.leadingAnchor, constant: 8),
                            self.scrollView.layoutMarginsGuide.trailingAnchor.constraint(equalTo: partLabel.trailingAnchor, constant: 8)
                        ])
                        if index > 0 {
                            partLabel.topAnchor.constraint(equalTo: addedViews[addedViews.count - 1].bottomAnchor, constant: 8).isActive = true
                        } else {
                            partLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 36).isActive = true
                        }
                        addedViews.append(partLabel)
                        if articleDetails.imageGalleruURL.count > index {
                            let imageView = UIImageView()
                            self.scrollView.addSubview(imageView)
                            imageView.translatesAutoresizingMaskIntoConstraints = false
                            NSLayoutConstraint.activate([
                                imageView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
                                imageView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
                                imageView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
                                imageView.topAnchor.constraint(equalTo: partLabel.bottomAnchor, constant: 8),
                            ])
                            Data.loadImage(url: articleDetails.imageGalleruURL[index], afterLoad: {image in
                                if let image = image {
                                    imageView.setImage(myImage: image)
                                }
                            })
                            addedViews.append(imageView)
                        }
                        partLabel.font = UIFont.systemFont(ofSize: 16)
                        partLabel.text = part.html2String
                    }
                    if !addedViews.isEmpty {
                        addedViews[addedViews.count - 1].bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true
                    }
                    self.activityIndicator.removeFromSuperview()
                    self.reloadButton.removeFromSuperview()
                }
            }
        }
    }
}
