//
//  ItemCollectionViewCell.swift
//  GalleryTest
//
//  Created by Yang, Tyler on 2/1/17.
//  Copyright © 2017 cincas. All rights reserved.
//

import Foundation
import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    var itemViewModel: ItemViewModel? {
        didSet {
            guard let itemViewModel = itemViewModel else {
                return
            }
            titleLabel.text = itemViewModel.title

            thumbnailView.image = nil

            itemViewModel.bind(withImageView: thumbnailView)
        }
    }

    let titleLabel = TYLabel()
    let thumbnailView = UIImageView()
    fileprivate let containerView = UIView()
    fileprivate var thumbnailRatioConstraint: NSLayoutConstraint?

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.autoresizingMask = [.flexibleHeight]
        contentView.backgroundColor = UIColor(red: 26.0 / 255.0, green: 26.0 / 255.0, blue: 26.0 / 255.0, alpha: 1.0)

        containerView.addSubview(titleLabel)
        containerView.addSubview(thumbnailView)
        contentView.addSubview(containerView)
        containerView.pinTo(view: contentView, onEdges: [.left, .right, .top, .bottom])

        thumbnailView.backgroundColor = .gray
        thumbnailView.contentMode = .scaleAspectFill
        thumbnailView.clipsToBounds = true
        thumbnailView.pinTo(view: containerView, onEdges: [.left, .top, .right])

        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.textColor = .white
        containerView.addConstraints([
            titleLabel.leftAnchor.constraint(equalTo: containerView.layoutMarginsGuide.leftAnchor, constant: 0),
            titleLabel.rightAnchor.constraint(equalTo: containerView.layoutMarginsGuide.rightAnchor, constant: 0)
            ])
        titleLabel.pin(edge: .top, toView: thumbnailView, withOffset: 8.0, onEdge: .bottom)

        let titleLabelConstraint = titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor)
        titleLabelConstraint.priority = UILayoutPriorityDefaultHigh
        containerView.addConstraint(titleLabelConstraint)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        return layoutAttributes
    }

    override func updateConstraints() {
        super.updateConstraints()
        if thumbnailRatioConstraint == nil {
            let ratioConstraint = thumbnailView.heightAnchor.constraint(equalTo: thumbnailView.widthAnchor, multiplier: 9.0 / 16.0)

            thumbnailView.addConstraint(ratioConstraint)
            thumbnailRatioConstraint = ratioConstraint
        }
    }
}
