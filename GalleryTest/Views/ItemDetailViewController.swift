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
        title = item.title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        dismissButton.setTitle("Dismiss", for: .normal)
        dismissButton.setTitleColor(.white, for: .normal)
        dismissButton.addTarget(self, action: #selector(close), for: .touchUpInside)

        view.addSubview(dismissButton)
        dismissButton.pinTo(view: view, onEdges: [.centerX, .bottom])

        view.addSubview(imageView)
        imageView.pinTo(view: view, onEdges: [.left, .right])

        let topConstraint = imageView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 0)
        view.addConstraint(topConstraint)

        let imageViewRatioConstraint = imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 9.0 / 16.0)
        
        imageView.addConstraint(imageViewRatioConstraint)
        imageView.clipsToBounds = true
    }

    func close() {
        if isBeingPresented {
            dismiss(animated: true, completion: nil)
        } else if navigationController != nil {
            _ = navigationController?.popViewController(animated: true)
        }
    }
}

extension ItemDetailViewController: TransitionDestinationLike {
    func transitionWillBegin() {
        view.layoutIfNeeded()
        imageView.isHidden = true
    }

    func transitionDidEnd() {
        imageView.isHidden = false
    }

    var transitionableFrame: CGRect {
        return imageView.frame
    }
}
