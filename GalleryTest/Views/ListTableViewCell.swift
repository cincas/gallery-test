//  Copyright © 2017 cincas. All rights reserved.

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
        contentView.autoresizingMask = [.flexibleHeight]

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: itemCellIdentifier)
        contentView.addSubview(collectionView)
        collectionView.pinTo(view: contentView, onEdges: [.left, .right, .bottom, .top])

        collectionView.contentInset = UIEdgeInsets(top: 0, left: 8.0, bottom: 0.0, right: 0.0)
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

        switch (sectionType, UIDevice.current.orientation.isLandscape, UIDevice.current.userInterfaceIdiom) {
        case (.normal, _, .phone):
            return 3.5
        case (.large, _, .phone):
            return 2.5
        case (.normal, false, _):
            return 4.5
        case (.normal, true, _):
            return 5.5
        case (.large, false, _):
            return 2.5
        case (.large, true, _):
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
