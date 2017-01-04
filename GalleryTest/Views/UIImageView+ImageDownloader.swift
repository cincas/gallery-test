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
            case let .success(image):
                // FIXME: async loading images sometime still cause incorrect image
                DispatchQueue.main.async {
                    sself.image = image
                }
            case .failure(_):
                debugPrint("failed to download image")
            }
        }
    }
}
