//
//  UIView+AutoLayout.swift
//  GalleryTest
//
//  Created by Yang, Tyler on 1/1/17.
//  Copyright © 2017 cincas. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func pinTo(view: UIView, onEdges edges: [NSLayoutAttribute], offset: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        let constraints = edges.flatMap { [weak self] attribute -> NSLayoutConstraint? in
            guard let sself = self else { return nil }
            return NSLayoutConstraint(item: sself, attribute: attribute, relatedBy: .equal, toItem: view, attribute: attribute, multiplier: 1, constant: offset)
        }
        commonSuperView(withView: view)?.addConstraints(constraints)
    }

    func pin(edge: NSLayoutAttribute, toView view: UIView, withOffset offset: CGFloat = 0, onEdge: NSLayoutAttribute? = nil) {
        let toEdge: NSLayoutAttribute = (onEdge != nil) ? onEdge! : edge
        let constraint = NSLayoutConstraint(item: self, attribute: edge, relatedBy: .equal, toItem: view, attribute: toEdge, multiplier: 1, constant: offset)
        commonSuperView(withView: view)?.addConstraint(constraint)
    }

    private func commonSuperView(withView view: UIView) -> UIView? {
        if superview == view.superview {
            // siblings
            return superview
        }

        if superview == view {
            return view
        }

        if view.superview == self {
            return self
        }

        return nil
    }
}
