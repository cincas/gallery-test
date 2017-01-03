//
//  GalleryViewModel.swift
//  GalleryTest
//
//  Created by Yang, Tyler on 2/1/17.
//  Copyright © 2017 cincas. All rights reserved.
//

import UIKit

class GalleryViewModel {
    let sectionViewModels: [SectionViewModel]
    init(dataSource: DataSource) {
        sectionViewModels = dataSource.sections.map {
            return SectionViewModel(section: $0)
        }
    }

    func sectionTitle(atIndex index: Int) -> String {
        return sectionViewModels[index].section.title
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
    let title: String
    let id: String
    
    init(item: Item) {
        self.item = item
        title = item.title
        id = item.id
        imageURL = item.imageURL
    }

    func bind(withImageView imageView: UIImageView) {
        guard imageURL == nil else {
            imageView.setImage(fromURL: imageURL!)
            return
        }

        extractImageURL(fromURL: URL(string: "http://www.colourlovers.com/api/patterns/random?format=json")!) { [weak imageView, weak self] result in
            switch result {
            case let .success(url):
                self?.imageURL = url
                imageView?.setImage(fromURL: url)
            case let .failure(error):
                print("Failed to get image url: \(error)")
            }
        }
    }
}

extension ItemViewModel: ColorLoversClientType {}
