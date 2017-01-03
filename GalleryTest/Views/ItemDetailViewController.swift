//
//  ItemDetailViewController.swift
//  GalleryTest
//
//  Created by Yang, Tyler on 2/1/17.
//  Copyright © 2017 cincas. All rights reserved.
//

import UIKit

class ItemDetailViewController: UIViewController {
    fileprivate let dismissButton = UIButton()
    fileprivate let imageView = UIImageView()
    fileprivate let titleLabel = UILabel()

    fileprivate let itemViewModel: ItemViewModel

    init(itemViewModel: ItemViewModel) {
        self.itemViewModel = itemViewModel
        if let imageURL = itemViewModel.imageURL {
            imageView.setImage(fromURL: imageURL)
        }
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        super.init(nibName: nil, bundle: nil)
        title = itemViewModel.id
        titleLabel.text = itemViewModel.title
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

        view.addConstraint(
            imageView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 0)
        )

        imageView.addConstraint(
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 9.0 / 16.0)
        )

        view.addSubview(titleLabel)
        view.addConstraints([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20)
            ])

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    func close() {
        if navigationController != nil {
            _ = navigationController?.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
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
