//
//  TweetsListViewController.swift
//  Bell-Twitter-Test
//
//  Created by Jigs on 2019-09-29.
//  Copyright © 2019 Jignesh Rajodiya. All rights reserved.
//

import UIKit
import CoreLocation
import TwitterKit

class TweetsListViewController: UIViewController {

    @IBOutlet weak var tweetsListTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let presenter = TweetsListPresenter()
    var tweetsArray = [Tweet]()
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
        
        presenter.attachView(view: self)
        loadingSpinner = getLoadingAlert()
       
        searchBar.placeholder = "Search #tags, trends, etc"
        searchBar.searchBarStyle = .minimal
        searchBar.delegate = self
        
        searchBar.backgroundColor = .groupTableViewBackground
    }
    
    private func loadTweets() {
        presenter.fetchTweetsWith("food")
    }
}

extension TweetsListViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchText = searchBar.text else { return }
        searchBar.endEditing(true)
        presenter.fetchTweetsWith(searchText)
    }
}

extension TweetsListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweetsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableCells.tweetCell, for: indexPath) as? TweetsTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configureCell(tweetsArray[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.fetchTweetDetails(tweetsArray[indexPath.row].id )
    }
}

extension TweetsListViewController {
    
    func showLoading() {
        show(loadingSpinner)
    }
    
    func hideLoading() {
        loadingSpinner.hide()
    }
 
    func reloadTweetsList(data: [Tweet]) {
        tweetsArray = data
        tweetsListTableView.reloadData()
    }
    
    func showTweetDetailView(_ tweet: TWTRTweet) {
        
        let storyboard = UIStoryboard(name: "TweetDetails", bundle: nil)
        let tweetDetailVC: TweetDetailsViewController = storyboard.instantiateInitialViewController() as! TweetDetailsViewController
        tweetDetailVC.tweet = tweet
        
        self.parent?.navigationController?.pushViewController(tweetDetailVC, animated: true)
        
    }
}

