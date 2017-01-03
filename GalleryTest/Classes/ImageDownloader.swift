//
//  ImageDownloader.swift
//  GalleryTest
//
//  Created by Yang, Tyler on 1/1/17.
//  Copyright © 2017 cincas. All rights reserved.
//

import UIKit

enum Result<T, Error> {
    case success(T)
    case failure(Error)
}

enum NetworkError: Error {
    case unknown
    case network
    case malformed
}

typealias ImageDownloadCompletionHandler = (Result<UIImage, NetworkError>) -> Void

class ImageDownloader {
    static let shared = ImageDownloader(cachePool: ImageCachePool())
    fileprivate let cachePool: ImageCacheLike
    fileprivate var tasks = [ImageDownloadTask]()

    init(cachePool: ImageCacheLike) {
        self.cachePool = cachePool
    }

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
                // FIXME: one potential problem of this is multiple requests to same uncached image
                if let index = sself.tasks.index(where: {
                    $0.cacheKey == downloadTask.cacheKey
                }) {
                    sself.tasks.remove(at: index)
                }
            case let .failure(error):
                // do nothing for now
                debugPrint("Image download failed: \(error)")
            }

            completionHandler(result)
        }
    }
}

struct ImageDownloadTask {
    let url: URL
    let cacheKey: String

    init(url: URL) {
        self.url = url
        cacheKey = url.absoluteString
    }

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
