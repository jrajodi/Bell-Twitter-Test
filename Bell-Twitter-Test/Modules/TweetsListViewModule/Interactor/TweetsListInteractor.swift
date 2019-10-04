//
//  TweetsListInteractor.swift
//  Bell-Twitter-Test
//
//  Created by Jigs on 2019-10-03.
//  Copyright © 2019 Jignesh Rajodiya. All rights reserved.
//

import Foundation

class TweetsListInteractor: TweetsListInteractorInputProtocol {
    
    weak var presenter: TweetsListInteractorOutputProtocol?
    
    func fetchTweets(_ keyword: String) {
        APIManager.shared.searchTweetsWith(keyword) { (result: TweetsResponse?) -> (Void) in
            if let tweets = result?.tweets, !tweets.isEmpty {
                self.presenter?.didRetrieveTweets(tweets)
            }
        }
    }

    func fetchTweetDetails(tweetId: Int) {
        APIManager.shared.fetchTweetDetail(tweetId: tweetId) { (tweet, error) -> (Void) in
            guard tweet != nil else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { self.presenter?.didRetrieveTweetForListDetails(tweet: tweet!) }
        }
    }
}
