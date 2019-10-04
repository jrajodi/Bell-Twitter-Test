//
//  TweetDetailsViewTests.swift
//  Bell-Twitter-TestTests
//
//  Created by Jigs on 2019-09-30.
//  Copyright © 2019 Jignesh Rajodiya. All rights reserved.
//

import XCTest

class TweetDetailsViewTests: XCTestCase {

    var tweetDetailView: TweetDetailsViewController!
    
    override func setUp() {
        let storyboard = UIStoryboard(name: "TweetDetails", bundle: nil)
        tweetDetailView = storyboard.instantiateInitialViewController() as? TweetDetailsViewController
    }

    func testRetweet() {
        
        APIManager.shared.retweet(forTweetRequestId: "1234", tweetId: "968013469743288300") { (success) in
            if success {
                XCTAssert(true, "You have successfully retweeted.")
            } else {
                XCTAssert(false, "Something wrong while retweeting.")
            }
        }
    }
}
