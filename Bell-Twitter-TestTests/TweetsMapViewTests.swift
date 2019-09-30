//
//  TweetsMapViewTests.swift
//  Bell-Twitter-TestTests
//
//  Created by Jigs on 2019-09-30.
//  Copyright © 2019 Jignesh Rajodiya. All rights reserved.
//

import XCTest

class TweetsMapViewTests: XCTestCase {

    var tweetsMapView: TweetsMapViewController!
    
    override func setUp() {
        let storyboard = UIStoryboard(name: "TweetsMap", bundle: nil)
        tweetsMapView = storyboard.instantiateInitialViewController() as! TweetsMapViewController
        _ = tweetsMapView.view
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
    
    func testNavigationTitle() {
        XCTAssertEqual("Most Recent Tweets", tweetsMapView.navigationItem.title)
    }
    
    func testFetchMostRecentTweets() {
        tweetsMapView.presenter.fetchMostRecentTweets(radius: 10)
    }

    func testTweetsParsing() {
        
        if let path = Bundle.main.path(forResource: "statuses", ofType: "json") {
            
            do {
                
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let tweetsResponse = try JSONDecoder().decode(TweetsResponse.self, from: data)
                if tweetsResponse.tweets.count == 7 {
                    XCTAssert(true, "Tweets are parsed successfully")
                } else {
                    XCTAssert(false, "Parsing Failed. Tweets response is not as expected json")
                }
                
            } catch {
                
                print(error)
                XCTAssert(false, "Parsing Failed. Tweets response is not as expected json")
            }
        }
    }
}
