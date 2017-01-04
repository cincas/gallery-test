//  Copyright © 2017 cincas. All rights reserved.

import UIKit

class PresentationAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    fileprivate let startFrame: CGRect
    fileprivate let sourceView: UIView
    fileprivate let destination: TransitionDestinationLike

    init(sourceView: UIView, destination: TransitionDestinationLike, startFrame: CGRect) {
        self.sourceView = sourceView
        self.destination = destination
        self.startFrame = startFrame
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)?.view,
            let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else {
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                return
        }

        let duration = transitionDuration(using: transitionContext)

        let containerView = transitionContext.containerView
        containerView.backgroundColor = .clear
        containerView.insertSubview(toView, belowSubview: fromView)
        let snapshotView = sourceView.snapshotView(afterScreenUpdates: true)!
        containerView.addSubview(snapshotView)

        fromView.alpha = 1.0
        toView.alpha = 0.0
        snapshotView.frame = startFrame

        destination.transitionWillBegin()
        UIView.animate(withDuration: duration, animations: {
            snapshotView.frame = self.destination.transitionableFrame
            toView.alpha = 1.0
            fromView.alpha = 0.0

        }) { finished in
            if finished {
                fromView.alpha = 1.0
                snapshotView.removeFromSuperview()
                transitionContext.completeTransition(finished)

                self.destination.transitionDidEnd()
            }
        }
    }
}
