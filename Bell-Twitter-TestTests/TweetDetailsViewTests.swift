//
//  TweetDetailsViewTests.swift
//  Bell-Twitter-TestTests
//
//  Created by Jigs on 2019-09-30.
//  Copyright © 2019 Jignesh Rajodiya. All rights reserved.
//

import XCTest

class TweetDetailsViewTests: XCTestCase {

    let presenter: TweetsDetailsPresenterProtocol = TweetsDetailsPresenter()
    var expectation: XCTestExpectation!
 
    func testRetweet() {
        APIManager.shared.retweet(forTweetRequestId: "1234", tweetId: "968013469743288300") { (success) in
            if success {
                XCTAssert(true, "You have successfully retweeted.")
            } else {
                XCTAssert(false, "Something wrong while retweeting.")
            }
        }
    }
    
    func testMarkFavourite() {
        APIManager.shared.favoriteTweet(forID: "9680134697432883") { (success) in
            if success {
                XCTAssert(true, "You have successfully retweeted.")
            } else {
                XCTAssert(false, "Something wrong while retweeting.")
            }
        }
    }
}
