//
//  ConfigureCell.swift
//  Bell-Twitter-Test
//
//  Created by Jigs on 2019-09-29.
//  Copyright © 2019 Jignesh Rajodiya. All rights reserved.
//

import Foundation

protocol ConfigureCell {
    
    associatedtype T
    func configureCell(_ data: T)
}
