//
//  TweetListPresenter.swift
//  Bell-Twitter-Test
//
//  Created by Jigs on 2019-10-03.
//  Copyright © 2019 Jignesh Rajodiya. All rights reserved.
//

import Foundation
import TwitterKit

class TweetListPresenter: TweetsListPresenterProtocol {
    weak var view: TweetsListViewProtocol?
    var interactor: TweetsListInteractorInputProtocol?
    var wireFrame: TweetsListWireFrameProtocol?
  
    func fetchTweets(_ keyword: String) {
        view?.showLoading()
        interactor?.fetchTweets(keyword)
    }
    
    func showTweetDetails(forTweet tweet: TWTRTweet) {
        wireFrame?.presentTweetDetailsScreen(from: view!, forTweet: tweet)
    }
    
    func fetchTweetDetails(tweetId: Int) {
        view?.showLoading()
        interactor?.fetchTweetDetails(tweetId: tweetId)
    }
}

extension TweetListPresenter: TweetsListInteractorOutputProtocol {
    func didRetrieveTweetForListDetails(tweet: TWTRTweet) {
        view?.hideLoading()
        view?.showTweetDetails(with: tweet)
    }
    
    func didRetrieveTweets(_ tweets: [Tweet]) {
        view?.hideLoading()
        view?.showTweets(with: tweets)
    }
}
