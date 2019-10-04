//
//  TweetsMapProtocols.swift
//  Bell-Twitter-Test
//
//  Created by Jigs on 2019-10-03.
//  Copyright © 2019 Jignesh Rajodiya. All rights reserved.
//

import Foundation
import UIKit
import TwitterKit

protocol TweetsMapViewProtocol: class {
    var presenter: TweetsMapPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func showLoading()
    func hideLoading()
    func showTweets(with tweets: [Tweet])
    func showTweetDetails(with tweet: TWTRTweet)
}

protocol TweetsMapWireFrameProtocol: class {
    static func createTweetsMapViewModule() -> UIViewController
    func presentTweetDetailsScreen(from view: TweetsMapViewProtocol, forTweet tweet: TWTRTweet)
}

protocol TweetsMapPresenterProtocol: class {
    var view: TweetsMapViewProtocol? { get set }
    var interactor: TweetsMapInteractorInputProtocol? { get set }
    var wireFrame: TweetsMapWireFrameProtocol? { get set }
    
    // VIEW -> PRESENTER
    func fetchMostRecentTweets(radius: Int)
    func showTweetDetails(forTweet tweet: TWTRTweet)
    func fetchTweetDetails(tweetId: Int)
}

protocol TweetsMapInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func didRetrieveMostRecentTweets(_ tweets: [Tweet])
    func didRetrieveTweetDetails (tweet: TWTRTweet)
    
    func onError()
}

protocol TweetsMapInteractorInputProtocol: class {
    var presenter: TweetsMapInteractorOutputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func fetchMostRecentTweets(radius: Int)
    func fetchTweetDetails(tweetId: Int)
}
