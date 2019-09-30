//
//  Defaults.swift
//  Bell-Twitter-Test
//
//  Created by Jigs on 2019-09-29.
//  Copyright © 2019 Jignesh Rajodiya. All rights reserved.
//

import Foundation

class Defaults {
    
    static let shared = Defaults()

    func setInt(_ value: Int, key: String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
 
    func getInt(_ key: String) -> Int {
        return UserDefaults.standard.integer(forKey: key)
    }
}
