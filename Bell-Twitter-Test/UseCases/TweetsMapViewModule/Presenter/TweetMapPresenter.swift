//
//  TweetsMapPresenter.swift
//  Bell-Twitter-Test
//
//  Created by Jigs on 2019-10-03.
//  Copyright © 2019 Jignesh Rajodiya. All rights reserved.
//

import Foundation
import TwitterKit

class TweetMapPresenter: TweetsMapPresenterProtocol {
    weak var view: TweetsMapViewProtocol?
    var interactor: TweetsMapInteractorInputProtocol?
    var wireFrame: TweetsMapWireFrameProtocol?
    
    func fetchMostRecentTweets(radius: Int) {
        view?.showLoading()
        interactor?.fetchMostRecentTweets(radius: radius)
    }
    
    func showTweetDetails(forTweet tweet: TWTRTweet) {
        wireFrame?.presentTweetDetailsScreen(from: view!, forTweet: tweet)
    }
    
    func fetchTweetDetails(tweetId: Int) {
        view?.showLoading()
        interactor?.fetchTweetDetails(tweetId: tweetId)
    }
}

extension TweetMapPresenter: TweetsMapInteractorOutputProtocol {
    func didRetrieveTweetDetails(tweet: TWTRTweet) {
        view?.hideLoading()
        view?.showTweetDetails(with: tweet)
    }
    
    func didRetrieveMostRecentTweets(_ tweets: [Tweet]) {
        view?.hideLoading()
        view?.showTweets(with: tweets)
    }
    
    func onError() {
        view?.hideLoading()
    }
}
