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
        ImageDownloader.shared.downloadImage(with: url) { [weak self] result in
            guard let sself = self else { return }
            switch result {
            case let .success(image):
                DispatchQueue.main.async {
                    sself.image = image
                }
            case .failure(_):
                debugPrint("failed to download image")
            }
        }
    }
}

extension UIImageView: ColorLoversClientType {
    func setRandomImage(fromURL url: URL) {
        if image == nil {
            extractImageURL(fromURL: url) { result in
                switch result {
                case let .success(imageURL):
                    self.setImage(fromURL: imageURL)
                    break
                case .failure(_):
                    break
                }
            }
        }
    }
}
