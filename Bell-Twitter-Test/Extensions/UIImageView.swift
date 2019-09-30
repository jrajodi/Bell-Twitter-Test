//
//  UIImageView.swift
//  Bell-Twitter-Test
//
//  Created by Jigs on 2019-09-29.
//  Copyright © 2019 Jignesh Rajodiya. All rights reserved.
//

import UIKit
import Foundation

extension UIImageView {
    func loadImage(url: URL) {
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
