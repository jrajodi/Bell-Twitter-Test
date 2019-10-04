//
//  TweetsMapViewTests.swift
//  Bell-Twitter-TestTests
//
//  Created by Jigs on 2019-09-30.
//  Copyright © 2019 Jignesh Rajodiya. All rights reserved.
//

import XCTest

class TweetsMapViewTests: XCTestCase {
    let presenter: TweetsMapPresenterProtocol & TweetsMapInteractorOutputProtocol = TweetMapPresenter()
    
    func testFetchMostRecentTweets() {
        presenter.fetchMostRecentTweets(radius: 100)
    }
    
    func fetchTweetDetails() {
        presenter.fetchTweetDetails(tweetId: 1234)
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
