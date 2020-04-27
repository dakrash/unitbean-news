//
//  ArticleListViewController + UIScrollViewDelegate.swift
//  unitbean-news
//
//  Created by darya on 25.04.2020.
//  Copyright © 2020 darya. All rights reserved.
//

import UIKit

extension ArticleListViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= scrollView.contentSize.height - scrollView.frame.height - 500 && !isLoadingData {
            switch self.getNetworkType() {
            case .wifi:
                if !self.loadMoreIndicator.isAnimating {
                    self.loadMoreButton.isHidden = true
                    self.loadMoreIndicator.startAnimating()
                }
                DispatchQueue.global().async {
                    self.getArticles()
                }
            case .unavailable:
                errorLoadMore()
            default:
                if self.loadMoreButton.isHidden {
                    self.loadMoreButton.setAttributedTitle(NSAttributedString(string: "ЗАГРУЗИТЬ ЕЩЁ", attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]), for: .normal)
                    self.loadMoreButton.setImage(nil, for: .normal)
                    self.loadMoreButton.isHidden = false
                    self.loadMoreIndicator.stopAnimating()
                }
            }
        }
    }
}
