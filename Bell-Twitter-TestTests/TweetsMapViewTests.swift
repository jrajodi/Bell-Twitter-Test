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
        tweetsMapView = storyboard.instantiateInitialViewController() as? TweetsMapViewController
        _ = tweetsMapView.view
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
