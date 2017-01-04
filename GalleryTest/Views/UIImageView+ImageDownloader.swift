//
//  UIImageView+ImageDownloader.swift
//  GalleryTest
//
//  Created by Yang, Tyler on 2/1/17.
//  Copyright © 2017 cincas. All rights reserved.
//

import UIKit

extension UIImageView {
    func setImage(fromURL url: URL) {
        ImageDownloader.shared.downloadImage(for: self, from: url)
    }
}

