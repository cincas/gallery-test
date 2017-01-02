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
    let titleLabel = UILabel()
    let thumbnailView = UIImageView()
    let containerView = UIView()
    override init(frame: CGRect) {
        super.init(frame: frame)

        containerView.addSubview(titleLabel)
        containerView.addSubview(thumbnailView)
        contentView.addSubview(containerView)
        containerView.pinTo(view: contentView, onEdges: [.left, .right, .top, .bottom])
        contentView.backgroundColor = .yellow
        thumbnailView.pinTo(view: containerView, onEdges: [.left, .top, .right])
        
        titleLabel.pinTo(view: containerView, onEdges: [.left, .right, .bottom])
        titleLabel.pin(edge: .top, toView: thumbnailView, onEdge: .bottom)

        thumbnailView.backgroundColor = .gray
        titleLabel.text = "This is a title.............. . . .. .. . .. . .. . .. ."
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping

        let thumbnailRatioConstraint = NSLayoutConstraint(item: thumbnailView, attribute: .height, relatedBy: .equal, toItem: thumbnailView, attribute: .width, multiplier: 9.0 / 16.0, constant: 0)
        thumbnailView.addConstraint(thumbnailRatioConstraint)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let attributes = layoutAttributes
        return attributes
    }

    var item: Item? {
        didSet {
            titleLabel.text = item?.title
        }
    }
}
