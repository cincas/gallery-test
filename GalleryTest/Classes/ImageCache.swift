//
//  ImageCache.swift
//  GalleryTest
//
//  Created by Yang, Tyler on 2/1/17.
//  Copyright © 2017 cincas. All rights reserved.
//

import UIKit

protocol ImageCacheLike {
    func cacheImage(_ image: UIImage, cacheKey: String)
    func loadImage(withCacheKey key: String) -> UIImage?
}

struct ImageCachePool: ImageCacheLike {
    private let cache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.name = "Image cache"
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 50
        return cache
    }()

    func cacheImage(_ image: UIImage, cacheKey: String) {
        cache.setObject(image, forKey: cacheKey as NSString)
    }

    func loadImage(withCacheKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
}
