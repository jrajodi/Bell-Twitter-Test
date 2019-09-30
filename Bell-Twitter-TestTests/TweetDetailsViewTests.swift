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
        tweetDetailView = storyboard.instantiateInitialViewController() as! TweetDetailsViewController
        _ = tweetDetailView.view
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
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
