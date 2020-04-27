//
//  Data + extension.swift
//  unitbean-news
//
//  Created by darya on 26.04.2020.
//  Copyright © 2020 darya. All rights reserved.
//

import UIKit

extension Data {
    static func loadImage(url: URL, afterLoad : @escaping (UIImage?)-> Void) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        afterLoad(image)
                    }
                    return
                }
            }
            afterLoad(nil)
        }
    }
    
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}
