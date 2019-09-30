//
//  UITableView.swift
//  Bell-Twitter-Test
//
//  Created by Jigs on 2019-09-29.
//  Copyright © 2019 Jignesh Rajodiya. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
 
    func registerCell(with name: String) {
        register(UINib(nibName: name, bundle: nil), forCellReuseIdentifier: name)
    }
    
    func registerClass(with name: String) {
        register(NSClassFromString(name).self, forCellReuseIdentifier: name)
    }
}
