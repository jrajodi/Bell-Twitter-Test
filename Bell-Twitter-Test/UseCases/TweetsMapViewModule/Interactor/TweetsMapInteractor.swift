//
//  TweetsMapInteractor.swift
//  Bell-Twitter-Test
//
//  Created by Jigs on 2019-10-03.
//  Copyright © 2019 Jignesh Rajodiya. All rights reserved.
//

import Foundation

class TweetsMapInteractor: TweetsMapInteractorInputProtocol {
    weak var presenter: TweetsMapInteractorOutputProtocol?
    
    func fetchMostRecentTweets(radius: Int) {
        APIManager.shared.searchWithRadius(radius) { (result: TweetsResponse?) -> (Void) in
            if let tweets = result?.tweets, !tweets.isEmpty { self.presenter?.didRetrieveMostRecentTweets(tweets) }
        }
    }
    
    func fetchTweetDetails(tweetId: Int) {
        APIManager.shared.fetchTweetDetail(tweetId: tweetId) { (tweet, error) -> (Void) in
            guard tweet != nil else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { self.presenter?.didRetrieveTweetDetails(tweet: tweet!) }
        }
    }
}
