//
//  TweetsListPresenter.swift
//  Bell-Twitter-Test
//
//  Created by Jigs on 2019-09-29.
//  Copyright © 2019 Jignesh Rajodiya. All rights reserved.
//

import Foundation

class TweetsListPresenter {
    var view: TweetsListViewController?
    func attachView(view: TweetsListViewController) {
        self.view = view
    }
}

extension TweetsListPresenter: TweetsProtocol {
    
    func fetchMostRecentTweets(radius: Int) {
        view?.showLoading()
        
        APIManager.shared.searchWithRadius(radius) { (result: TweetsResponse?) -> (Void) in
            
            self.view?.hideLoading()
            if let tweets = result?.tweets, !tweets.isEmpty {
                self.view?.reloadTweetsList(data: tweets)
            }
        }
    }
    
    func fetchTweetsWith(_ keyword: String) {
        
        view?.showLoading()
        APIManager.shared.searchTweetsWith(keyword) { (result: TweetsResponse?) -> (Void) in
            self.view?.hideLoading()
            if let tweets = result?.tweets, !tweets.isEmpty {
                self.view?.reloadTweetsList(data: tweets)
            }
        }
    }
    
    func fetchTweetDetails(_ tweetId: Int) {
        
        view?.showLoading()
        
        APIManager.shared.fetchTweetDetail(tweetId: tweetId) { (tweet, error) -> (Void) in
            
            self.view?.hideLoading()
            guard tweet != nil else {
                return
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.view?.showTweetDetailView(tweet!)
            }
        }
    }
}
