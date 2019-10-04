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

    var tweetsView: TweetsListViewController!
    var tableView: UITableView!
    
    override func setUp() {
        let storyboard = UIStoryboard(name: "TweetsList", bundle: nil)
        tweetsView = storyboard.instantiateInitialViewController() as? TweetsListViewController
        tableView = tweetsView.tweetsListTableView
    }

    func testIfControllerHasTableView() {
        XCTAssertNotNil(tableView, "Controll should have the table view")
    }
    
    func testTableHasThreeNumberOfSections() {
        XCTAssertEqual(tableView?.numberOfSections, 1, "Tweets Table should have 1 sections")
    }
    
    func testNavigationTitle() {
        XCTAssertEqual("Most Recent Tweets", tweetsView.navigationItem.title)
    }
    
    func testFetchTweetsBasedOnHashTag() {
        tweetsView.presenter.fetchTweetsWith("#food")
    }
    
    func testIfTableViewHasTweetCell() {
        
        let cellIdentifier = TableCells.tweetCell
        let indexPath = IndexPath(row: 0, section: 0)
        guard tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) is (TweetsTableViewCell) else {
            XCTAssertNil("Table View Should be able to deque cell with identifier: \(cellIdentifier)")
            return
        }
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
    
    func testTweetsLoadingInTableView() {
        tweetsView.tweetsListTableView.reloadData()
    }
    
    func testTweetCellWithData() {
        
        if let path = Bundle.main.path(forResource: "statuses", ofType: "json") {
            
            do {
                
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let tweetsResponse = try JSONDecoder().decode(TweetsResponse.self, from: data)
                
                let cellIdentifier = TableCells.tweetCell
                let indexPath = IndexPath(row: 0, section: 0)
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TweetsTableViewCell
                cell?.configureCell(tweetsResponse.tweets[0])
                
            } catch {
                
                print(error)
                XCTAssert(false, "Parsing Failed. Tweets response is not as expected json")
            }
        }
    }
}
