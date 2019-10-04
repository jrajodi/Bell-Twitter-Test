//
//  TweetsListProtocols.swift
//  Bell-Twitter-Test
//
//  Created by Jigs on 2019-10-03.
//  Copyright © 2019 Jignesh Rajodiya. All rights reserved.
//

import Foundation
import UIKit
import TwitterKit

protocol TweetsListViewProtocol: class {
    var presenter: TweetsListPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func showLoading()
    func hideLoading()
    func showTweets(with tweets: [Tweet])
    func showTweetDetails(with tweet: TWTRTweet)
}

protocol TweetsListWireFrameProtocol: class {
    static func createTweetsListViewModule() -> UIViewController
    func presentTweetDetailsScreen(from view: TweetsListViewProtocol, forTweet tweet: TWTRTweet)
}

protocol TweetsListPresenterProtocol: class {
    var view: TweetsListViewProtocol? { get set }
    var interactor: TweetsListInteractorInputProtocol? { get set }
    var wireFrame: TweetsListWireFrameProtocol? { get set }
    
    // VIEW -> PRESENTER
    func fetchTweets(_ keyword: String)
    func showTweetDetails(forTweet tweet: TWTRTweet)
    func fetchTweetDetails(tweetId: Int)
}

protocol TweetsListInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func didRetrieveTweets(_ tweets: [Tweet])
    func didRetrieveTweetForListDetails (tweet: TWTRTweet)
}

protocol TweetsListInteractorInputProtocol: class {
    var presenter: TweetsListInteractorOutputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func fetchTweets(_ keyword: String)
    func fetchTweetDetails(tweetId: Int)
}
