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
    let collectionView: UICollectionView
    var sectionViewModel: SectionViewModel?

    weak var collectionViewCellDelegate: ItemCollectionViewCellDelegate?

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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ListTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sectionViewModel?.itemViewModels.count ?? 0
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionViewModel != nil ? 1 : 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemCellIdentifier, for: indexPath) as! ItemCollectionViewCell
        cell.itemViewModel = sectionViewModel?.itemViewModels[indexPath.row]
        return cell
    }
}

extension ListTableViewCell: UICollectionViewDelegateFlowLayout {
    private var itemsPerScreen: CGFloat {
        guard let sectionType = sectionViewModel?.type else { return 1 }

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

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = collectionView.bounds.size.width / itemsPerScreen
        return CGSize(width: itemWidth, height: collectionView.bounds.size.height)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        guard let cell = collectionView.cellForItem(at: indexPath) as? ItemCollectionViewCell else { return }
        collectionViewCellDelegate?.present(cell)
    }
}

protocol ItemCollectionViewCellDelegate: class {
    func present(_ cell: ItemCollectionViewCell)
}
