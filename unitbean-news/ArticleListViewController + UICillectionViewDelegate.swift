//
//  ArticleListViewController + UICillectionViewDelegate.swift
//  unitbean-news
//
//  Created by darya on 21.04.2020.
//  Copyright © 2020 darya. All rights reserved.
//

import UIKit

extension ArticleListViewController : UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ArticleCell.identifer, for: indexPath)
        cell.selectionStyle = .none
        guard let articleCell = cell as? ArticleCell else {return cell}
        let color = UIColor(hex: 0x7E7E7E).cgColor
        let article = self.articles[indexPath.row]
        articleCell.backgroundColor = .white
        articleCell.authorName.text = article.tag
        articleCell.title.text = article.title
        articleCell.date.text = article.date.getString()
        articleCell.comments.text = "\(article.commentsCount)"
        articleCell.commentsicon.addDashedBorder(color: color)
        guard let imageView = articleCell.im else {return cell}
        if let image = article.image {
            imageView.setImage(myImage: image)
            articleCell.imageActivityIndicator.stopAnimating()
        } else {
            imageView.image = nil
            articleCell.imageActivityIndicator.startAnimating()
            Data.loadImage(url: article.imageUrl, afterLoad: { image in
                if let image = image {
                    article.image = image
                    if let updateCell = tableView.cellForRow(at: indexPath) as? ArticleCell {
                        updateCell.imageActivityIndicator.stopAnimating()
                        updateCell.im?.setImage(myImage: image)
                    }
                }
            })
        }
        return articleCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "details") as? ArticleViewController else {return}
        viewController.article = articles[indexPath.row]
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
