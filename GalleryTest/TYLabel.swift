//
//  TYLabel.swift
//  GalleryTest
//
//  Created by Yang, Tyler on 2/1/17.
//  Copyright © 2017 cincas. All rights reserved.
//

import Foundation
import UIKit

class TYLabel: UILabel {
    override func drawText(in rect: CGRect) {
        guard let string = text else {
            super.drawText(in: rect)
            return
        }

        let stringSize = (string as NSString).boundingRect(
            with: CGSize(width: frame.width, height: CGFloat.greatestFiniteMagnitude),
            options: [.usesLineFragmentOrigin],
            attributes: [NSFontAttributeName: font],
            context: nil).size
        super.drawText(in: CGRect(x: 0, y: 0, width: stringSize.width, height: stringSize.height))
    }
}
