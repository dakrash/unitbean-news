//
//  ArticleRequest.swift
//  unitbean-news
//
//  Created by darya on 26.04.2020.
//  Copyright © 2020 darya. All rights reserved.
//

import UIKit
import Alamofire

class ArticleRequest {
    private let path = "https://meduza.io"
    private let api = "/api/v3/"
    private var page = 0
    public static let instance = ArticleRequest()
    
    private init(){}
    
    func getArticleList(complition: @escaping (([Article]?) -> Void)){
        AF.request("\(path)\(api)search?chrono=news&page=\(self.page)&per_page=24&locale=ru").responseJSON { (response) in
            switch response.result {
            case .success(let JSON):
                guard let response = JSON as? NSDictionary, let documents = response["documents"] as? [String : NSDictionary] else {
                    complition(nil)
                    return
                }
                var newArticles = [Article]()
                documents.forEach({ (articleJSON) in
                    if
                        let relativeUrl = articleJSON.value["url"] as? String,
                        let url = URL(string: "\(self.path)\(self.api)\(relativeUrl)"),
                        let dateDouble = articleJSON.value["published_at"] as? Double,
                        let tag = (articleJSON.value["tag"] as? NSDictionary)?["name"] as? String,
                        let imageDictionary = articleJSON.value["image"] as? [String : Any],
                        let relativeImageUrl = imageDictionary["small_url"] as? String,
                        let imageUrl = URL(string: "\(self.path)\(relativeImageUrl)"),
                        let title = articleJSON.value["title"] as? String
                    {
                        newArticles.append(Article(authorName: tag, date: Date(timeIntervalSince1970: dateDouble), imageUrl: imageUrl, commentsCount: Int.random(in: 0...100), title: title, url: url))
                    }
                })
                if !newArticles.isEmpty {
                    newArticles.sort {$0.date > $1.date}
                }
                self.page += 1
                complition(newArticles)
            case .failure(let error):
                print("Request failed with error: \(error)")
                complition(nil)
            }
        }
    }
    
    func getArticle(url : URL, complition: @escaping ((ArticleDetails?) -> Void)) {
        AF.request(url).responseJSON { (response) in
            switch response.result {
            case .success(let JSON):
                guard let response = (JSON as? NSDictionary)?["root"] as? NSDictionary, let content = response["content"] as? NSDictionary, let body = content["body"] as? String else {
                    complition(nil)
                    return
                }
                var galleryUrl = [URL]()
                if let gallery = response["gallery"] as? [NSDictionary]{
                    gallery.forEach { (galleryElement) in
                        if let small_url = galleryElement["small_url"] as? String, let url = URL(string: "\(self.path)\(small_url)") {
                            galleryUrl.append(url)
                        }
                    }
                }
                complition(ArticleDetails(imageGalleruURL: galleryUrl, htmlBody: body))
            case .failure(let error):
                print("Request failed with error: \(error)")
                complition(nil)
            }
        }
    }
}
