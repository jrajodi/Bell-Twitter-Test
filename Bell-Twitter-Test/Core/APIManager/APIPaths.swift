//
//  APIPaths.swift
//  Bell-Twitter-Test
//
//  Created by Jigs on 2019-09-28.
//  Copyright © 2019 Jignesh Rajodiya. All rights reserved.
//

import Foundation

public enum APIPath: String {
    case tweetRequest
    case postedTweet
    case favorite = "favorites/create.json"
    case search = "search/tweets.json"
    
    var url: String {
        return APIEndPoints.baseURL + self.rawValue
    }
}
