//
//  TweetsListViewTests.swift
//  Bell-Twitter-TestTests
//
//  Created by Jigs on 2019-09-30.
//  Copyright © 2019 Jignesh Rajodiya. All rights reserved.
//

import XCTest
@testable import TwitterKit

class TweetsListViewTests: XCTestCase {

    let presenter: TweetsListPresenterProtocol & TweetsListInteractorOutputProtocol = TweetListPresenter()
    
    func testFetchTweetsBasedOnHashTag() {
        presenter.fetchTweets("#food")
    }
    
    func testFetchTweetsBasedOnTrend() {
        presenter.fetchTweets("allbirds shoes")
    }
    
    func testFetchTweetsBasedOnKeyword() {
        presenter.fetchTweets("NASA")
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
