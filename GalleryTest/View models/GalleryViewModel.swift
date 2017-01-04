//
//  GalleryViewModel.swift
//  GalleryTest
//
//  Created by Yang, Tyler on 2/1/17.
//  Copyright © 2017 cincas. All rights reserved.
//

import UIKit

private let apiURL = URL(string: "http://www.colourlovers.com/api/patterns/random?format=json")!

class GalleryViewModel {
    let sectionViewModels: [SectionViewModel]
    var isReady = false
    init(dataSource: DataSource) {
        sectionViewModels = dataSource.sections.map {
            return SectionViewModel(section: $0)
        }
    }

    var numberOfSections: Int {
        return isReady ? sectionViewModels.count : 0
    }
    
    func sectionTitle(atIndex index: Int) -> String {
        return sectionViewModels[index].section.title
    }

    private let taskGroup = DispatchGroup()

    func prepareContent(completionHandler: @escaping (() -> Void)) {
        sectionViewModels.forEach { sectionViewModel in
            sectionViewModel.itemViewModels.forEach {
                self.taskGroup.enter()
                $0.prepareImageURL {
                    self.taskGroup.leave()
                }
            }
        }

        taskGroup.notify(queue: DispatchQueue.main) {
            self.isReady = true
            completionHandler()
        }
    }
}

class SectionViewModel {
    fileprivate let section: Section
    let type: Section.SectionType
    let title: String
    let itemViewModels: [ItemViewModel]

    init(section: Section) {
        self.section = section
        self.type = section.type
        self.title = section.title
        itemViewModels = section.items.map {
            return ItemViewModel(item: $0)
        }
    }
}

class ItemViewModel {
    fileprivate let item: Item
    var imageURL: URL?
    var title: String
    let id: String
    let backgroundColor: UIColor

    init(item: Item) {
        self.item = item
        title = item.title
        id = item.id
        imageURL = item.imageURL
        let red: CGFloat = CGFloat((Float(arc4random_uniform(255)) / 255.0))
        let green: CGFloat = CGFloat((Float(arc4random_uniform(255)) / 255.0))
        let yellow: CGFloat = CGFloat((Float(arc4random_uniform(255)) / 255.0))
        backgroundColor = UIColor(red: red, green: green, blue: yellow, alpha: 1.0)
    }

    fileprivate func prepareImageURL(completionHandler: @escaping (() -> Void)) {
        loadItem(from: apiURL) { result in
            switch result {
            case let .success(object):
                guard let imageURLString = object["imageUrl"] as? String,
                    let imageURL = URL(string: imageURLString),
                    let title = object["title"] as? String else {
                        fallthrough
                }

                self.imageURL = imageURL
                self.title = title
            default:
                break
            }

            completionHandler()

        }
    }

    func bind(withImageView imageView: UIImageView) {
        imageView.image = nil
        guard imageURL == nil else {
            imageView.setImage(fromURL: imageURL!)
            return
        }
    }
}

extension ItemViewModel: ColorLoversClientType {}
