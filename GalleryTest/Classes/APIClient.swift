//
//  APIClient.swift
//  GalleryTest
//
//  Created by Yang, Tyler on 1/1/17.
//  Copyright © 2017 cincas. All rights reserved.
//

import Foundation

protocol ColorLoversClientType {
    func extractImageURL(fromURL url: URL, completionHandler: @escaping ((Result<URL, Error>) -> Void))
}

extension ColorLoversClientType {
    func extractImageURL(fromURL url: URL, completionHandler: @escaping ((Result<URL, Error>) -> Void)) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completionHandler(.failure(error!))
                return
            }

            guard let data = data,
                let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]],
                let object = jsonObject?.first,
                let imageURLString = object["imageUrl"] as? String,
                let imageURL = URL(string: imageURLString) else {
                    completionHandler(.failure(NetworkError.malformed))
                    return
            }

            completionHandler(.success(imageURL))
        }.resume()
    }
}
