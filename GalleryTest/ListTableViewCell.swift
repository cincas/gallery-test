//
//  ListTableViewCell.swift
//  GalleryTest
//
//  Created by Yang, Tyler on 2/1/17.
//  Copyright © 2017 cincas. All rights reserved.
//

import Foundation
import UIKit

private let itemCellIdentifier = "listItemCell"
class ListTableViewCell: UITableViewCell {
    private let collectionView: UICollectionView
    var section: Section? {
        didSet {
            if oldValue?.title != section?.title {
                collectionView.reloadData()
            }
        }
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.minimumLineSpacing = 10
        collectionViewFlowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        collectionViewFlowLayout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)

        super.init(style: style, reuseIdentifier: reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: itemCellIdentifier)
        contentView.addSubview(collectionView)
        collectionView.pinTo(view: contentView, onEdges: [.left, .right, .bottom, .top])
        contentView.autoresizingMask = [.flexibleHeight]
        contentView.translatesAutoresizingMaskIntoConstraints = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ListTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.section?.items.count ?? 0
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return section != nil ? 1 : 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemCellIdentifier, for: indexPath) as! ItemCollectionViewCell
        cell.item = section?.items[indexPath.item]
        return cell
    }
}

extension ListTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = collectionView.bounds.size.width / itemsPerScreen
        return CGSize(width: itemWidth, height: collectionView.bounds.size.height)
    }

    private var itemsPerScreen: CGFloat {
        guard let sectionType = section?.type else { return 1 }

        switch (sectionType, UIDevice.current.orientation.isLandscape) {
        case (.normal, false):
            return 4.5
        case (.normal, true):
            return 5.5
        case (.large, false):
            return 2.5
        case (.large, true):
            return 3.5
        }
    }
}
