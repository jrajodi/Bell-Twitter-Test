//
//  TweetsProtocol.swift
//  Bell-Twitter-Test
//
//  Created by Jigs on 2019-09-29.
//  Copyright © 2019 Jignesh Rajodiya. All rights reserved.
//

import Foundation

protocol TweetsProtocol {
    func fetchMostRecentTweets(radius: Int)
    func fetchTweetDetails(_ tweetId: Int)
    func fetchTweetsWith(_ keyword: String)
}
