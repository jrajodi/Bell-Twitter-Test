//
//  Strings.swift
//  Bell-Twitter-Test
//
//  Created by Jigs on 2019-09-28.
//  Copyright © 2019 Jignesh Rajodiya. All rights reserved.
//

import Foundation

enum Strings: String, Localizable {

    case errorTitle = "Error"
    case successTitle = "Success"
    case loadingText = "Loading..."
    case loginErrorMessage = "Something went wrong!"
    
    var tableName: String {
        return "Localization"
    }
}

extension String {
    
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
    
    func urlEncode() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
}
