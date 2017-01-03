//
//  Transitionable.swift
//  GalleryTest
//
//  Created by Yang, Tyler on 3/1/17.
//  Copyright © 2017 cincas. All rights reserved.
//

import UIKit

protocol TransitionDestinationLike {
    var transitionableFrame: CGRect { get }
    func transitionWillBegin()
    func transitionDidEnd()
}

class TransitionDelegate: NSObject {
    var startFrame: CGRect
    var sourceView: UIView
    var destination: TransitionDestinationLike
    init(sourceView: UIView, destination: TransitionDestinationLike, startFrame: CGRect) {
        self.sourceView = sourceView
        self.destination = destination
        self.startFrame = startFrame
    }
}

extension TransitionDelegate: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentationAnimator(sourceView: sourceView, destination: destination, startFrame: startFrame)
    }
}

class NavigationTransitionDelegate: TransitionDelegate {}

extension NavigationTransitionDelegate: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let _ = toVC as? TransitionDestinationLike else {
            return nil
        }

        return PresentationAnimator(sourceView: sourceView, destination: destination, startFrame: startFrame)
    }
}
