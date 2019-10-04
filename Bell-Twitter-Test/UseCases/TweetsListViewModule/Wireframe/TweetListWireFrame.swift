//
//  TweetListWireFrame.swift
//  Bell-Twitter-Test
//
//  Created by Jigs on 2019-10-03.
//  Copyright © 2019 Jignesh Rajodiya. All rights reserved.
//

import Foundation
import UIKit
import TwitterKit

class TweetListWireFrame: TweetsListWireFrameProtocol {
    class func createTweetsListViewModule() -> UIViewController {
        let view: TweetListView = tweetListStoryboard.instantiateInitialViewController() as! TweetListView
        
        let presenter: TweetsListPresenterProtocol & TweetsListInteractorOutputProtocol = TweetListPresenter()
        let interactor: TweetsListInteractorInputProtocol = TweetsListInteractor()
        let wireFrame: TweetsListWireFrameProtocol = TweetListWireFrame()
        
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        return view
    }
    
    static var tweetListStoryboard: UIStoryboard {
        return UIStoryboard(name: "TweetList", bundle: Bundle.main)
    }
    
    func presentTweetDetailsScreen(from view: TweetsListViewProtocol, forTweet tweet: TWTRTweet) {
        //let postDetailViewController = PostDetailWireFrame.createPostDetailModule(forPost: post)

        let storyboard = UIStoryboard(name: "TweetDetails", bundle: nil)
        let tweetDetailVC: TweetDetailsViewController = storyboard.instantiateInitialViewController() as! TweetDetailsViewController
        tweetDetailVC.tweet = tweet
        
        if let sourceView = view as? UIViewController {
            sourceView.parent?.navigationController?.pushViewController(tweetDetailVC, animated: true)
        }
    }
}
