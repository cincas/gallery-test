//
//  ItemDetailViewController.swift
//  GalleryTest
//
//  Created by Yang, Tyler on 2/1/17.
//  Copyright © 2017 cincas. All rights reserved.
//

import UIKit

class ItemDetailViewController: UIViewController {
    let dismissButton = UIButton()
    let imageView = UIImageView()
    fileprivate let item: Item
    init(item: Item, image: UIImage?) {
        self.item = item
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green

        dismissButton.setTitle("Dismiss", for: .normal)
        dismissButton.addTarget(self, action: #selector(close), for: .touchUpInside)

        view.addSubview(dismissButton)
        dismissButton.pinTo(view: view, onEdges: [.centerX, .bottom])

        view.addSubview(imageView)
        imageView.pinTo(view: view, onEdges: [.left, .right, .top])
        let imageViewRatioConstraint = NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: imageView, attribute: .width, multiplier: 9.0/16.0, constant: 0)
        imageView.addConstraint(imageViewRatioConstraint)
        imageView.clipsToBounds = true
    }

    func close() {
        dismiss(animated: true, completion: nil)
    }
}

extension ItemDetailViewController: TransitionDestinationLike {
    func transitionWillBegin() {
        imageView.isHidden = true
    }

    func transitionDidEnd() {
        imageView.isHidden = false
    }

    var transitionableFrame: CGRect {
        return imageView.frame
    }
}
