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
    let titleLabel = TYLabel()
    let thumbnailView = UIImageView()
    let containerView = UIView()
    override init(frame: CGRect) {
        super.init(frame: frame)

        containerView.addSubview(titleLabel)
        containerView.addSubview(thumbnailView)
        contentView.addSubview(containerView)
        containerView.pinTo(view: contentView, onEdges: [.left, .right, .top, .bottom])
        contentView.backgroundColor = .black
        thumbnailView.pinTo(view: containerView, onEdges: [.left, .top, .right])
        
        titleLabel.pinTo(view: containerView, onEdges: [.left, .right, .bottom])
        titleLabel.pin(edge: .top, toView: thumbnailView, onEdge: .bottom)

        thumbnailView.backgroundColor = .gray
        thumbnailView.contentMode = .scaleAspectFill
        thumbnailView.clipsToBounds = true
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.textColor = .white

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
            guard let item = item else {
                return
            }
            titleLabel.text = item.title
            thumbnailView.setImage(with: item.imageURL)
        }
    }
}
