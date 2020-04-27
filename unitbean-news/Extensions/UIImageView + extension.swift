//
//  UIImageView + extension.swift
//  unitbean-news
//
//  Created by darya on 22.04.2020.
//  Copyright © 2020 darya. All rights reserved.
//

import UIKit

extension UIImageView {
    func setImage(myImage : UIImage){
        self.image = myImage
        self.contentMode = .scaleAspectFit
        let myImageWidth = myImage.size.width
        let myImageHeight = myImage.size.height
        let myViewWidth = self.frame.size.width
        if myImageWidth < myViewWidth {
            self.widthAnchor.constraint(equalToConstant: myImageWidth).isActive = true
            self.heightAnchor.constraint(equalToConstant: myImageHeight).isActive = true
        } else {
            let ratio = myViewWidth/myImageWidth
            let scaledHeight = myImageHeight * ratio
            self.heightAnchor.constraint(equalToConstant: scaledHeight).isActive = true
        }
    }
}
