//
//  UIView.swift
//  Bell-Twitter-Test
//
//  Created by Jigs on 2019-09-29.
//  Copyright © 2019 Jignesh Rajodiya. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func setRoundCorner() {
        clipsToBounds = true
        layer.cornerRadius = frame.height / 2
    }
    
    func setCornerRadius(_ radius: CGFloat) {
        layer.cornerRadius = radius
    }
}
