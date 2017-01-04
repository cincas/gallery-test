//
//  UIRefreshControl.swift
//  GalleryTest
//
//  Created by Yang, Tyler on 4/1/17.
//  Copyright © 2017 cincas. All rights reserved.
//

import UIKit

extension UIRefreshControl {
    func forceRefresh() {
        if let scrollView = superview as? UIScrollView {
            let contentOffset = CGPoint(x: 0, y: scrollView.contentOffset.y - frame.height)
            scrollView.setContentOffset(contentOffset, animated: true)
        }

        beginRefreshing()
    }
}
