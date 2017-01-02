//
//  ImageDownloader.swift
//  GalleryTest
//
//  Created by Yang, Tyler on 1/1/17.
//  Copyright © 2017 cincas. All rights reserved.
//

import Foundation

struct ImageDownloader {
    static let shared = ImageDownloader()
}

struct ImageDownloadTask {
    let url: URL
    let cacheKey: String
    init(url: URL) {
        self.url = url
        cacheKey = url.absoluteString
    }

    private let session = URLSession.shared
    private var dataTask: URLSessionDownloadTask?
    func start() {
    }
}

import UIKit
extension UIImageView {
    convenience init(url: URL, placeholderColor: UIColor = .gray) {
        self.init()
        backgroundColor = placeholderColor
    }
}
