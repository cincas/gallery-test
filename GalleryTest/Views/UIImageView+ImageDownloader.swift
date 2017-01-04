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
        ImageDownloader.shared.downloadImage(from: url) { [weak self] result in
            guard let sself = self else { return }
            switch result {
            case let .success(image, imageURL) where imageURL == url:
                DispatchQueue.main.async {
                    sself.image = image
                }
            case .failure(_), .success(_):
                sself.image = nil
                debugPrint("failed to download image")
            }
        }
    }
}
