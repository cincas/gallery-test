//
//  ImageDownloader.swift
//  GalleryTest
//
//  Created by Yang, Tyler on 1/1/17.
//  Copyright © 2017 cincas. All rights reserved.
//

import Foundation
import UIKit

enum ImageDownloadError {
    case unknown
    case network
    case malformed
}

enum Result<T, ImageDownloadError> {
    case success(T)
    case failure(ImageDownloadError)
}

typealias ImageDownloadCompletionHandler = (Result<UIImage, ImageDownloadError>) -> Void

class ImageDownloader {
    static let shared = ImageDownloader()
    fileprivate let cachePool = ImageCachePool()
    fileprivate var tasks = [ImageDownloadTask]()

    func downloadImage(with url: URL, completionHandler: @escaping ImageDownloadCompletionHandler) {
        let downloadTask = ImageDownloadTask(url: url)
        let cachedImage = cachePool.loadImage(withCacheKey: downloadTask.cacheKey)
        guard cachedImage == nil else {
            completionHandler(.success(cachedImage!))
            return
        }

        tasks.append(downloadTask)
        downloadTask.start { [weak self] result in
            guard let sself = self else { return }
            switch result {
            case let .success(image):
                sself.cachePool.cacheImage(image, cacheKey: downloadTask.cacheKey)
            case let .failure(error):
                // do nothing for now
                debugPrint("Image download failed: \(error)")
            }

            completionHandler(result)
        }
    }
}

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

struct ImageDownloadTask {
    let url: URL
    let cacheKey: String
    init(url: URL) {
        self.url = url
        cacheKey = url.absoluteString
    }

    private let session = URLSession.shared
    private var dataTask: URLSessionDownloadTask?
    func start(completionHandler: ImageDownloadCompletionHandler? = nil) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completionHandler?(.failure(.network))
                return
            }
            if let data = data, let image = UIImage(data: data) {
                completionHandler?(.success(image))
            } else {
                completionHandler?(.failure(.malformed))
            }
        }.resume()
    }
}

extension UIImageView {
    func setImage(with url: URL) {
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
