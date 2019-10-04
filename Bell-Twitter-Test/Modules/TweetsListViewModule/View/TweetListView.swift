//
//  TweetListView.swift
//  Bell-Twitter-Test
//
//  Created by Jigs on 2019-10-03.
//  Copyright © 2019 Jignesh Rajodiya. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import TwitterKit
import CoreLocation

class TweetListView: UIViewController {

    @IBOutlet weak var tweetsListTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var presenter: TweetsListPresenterProtocol?
    var tweets = [Tweet]()
    private var loadingSpinner: UIAlertController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        loadTweets()
    }
    
    private func setupView() {
        tweetsListTableView.registerCell(with: TableCells.tweetCell)
        tweetsListTableView.delegate = self
        tweetsListTableView.dataSource = self
        tweetsListTableView.separatorStyle = .none
        tweetsListTableView.backgroundColor = .groupTableViewBackground
        
        loadingSpinner = getLoadingAlert()
       
        searchBar.placeholder = "Search #tags, trends, etc"
        searchBar.searchBarStyle = .minimal
        searchBar.delegate = self
        
        searchBar.backgroundColor = .groupTableViewBackground
    }
    
    private func loadTweets() {
        self.presenter?.fetchTweets("#food")
    }
}

extension TweetListView: TweetsListViewProtocol {
    
    func showTweets(with tweets: [Tweet]) {
        self.tweets = tweets
        tweetsListTableView.reloadData()
        
    }
    
    func showTweetDetails(with tweet: TWTRTweet) {
        self.presenter?.showTweetDetails(forTweet: tweet)
    }
    
    func showLoading() {
        if !loadingSpinner.isBeingPresented {
            present(loadingSpinner, animated: true, completion: nil)
        }
    }
    
    func hideLoading() {
        loadingSpinner.hide()
    }
    
}


extension TweetListView: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchText = searchBar.text else { return }
        searchBar.endEditing(true)
        self.presenter?.fetchTweets(searchText)
    }
}

extension TweetListView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableCells.tweetCell, for: indexPath) as? TweetsTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configureCell(tweets[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter?.fetchTweetDetails(tweetId: tweets[indexPath.row].id)
    }
}

