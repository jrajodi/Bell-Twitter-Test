//
//  TweetMapWireFrame.swift
//  Bell-Twitter-Test
//
//  Created by Jigs on 2019-10-03.
//  Copyright © 2019 Jignesh Rajodiya. All rights reserved.
//

import Foundation
import UIKit
import TwitterKit

class TweetMapWireFrame: TweetsMapWireFrameProtocol {
    
    class func createTweetsMapViewModule() -> UIViewController {
        let view: TweetMapView = tweetMapStoryboard.instantiateInitialViewController() as! TweetMapView
        
        let presenter: TweetsMapPresenterProtocol & TweetsMapInteractorOutputProtocol = TweetMapPresenter()
        let interactor: TweetsMapInteractorInputProtocol = TweetsMapInteractor()
        let wireFrame: TweetsMapWireFrameProtocol = TweetMapWireFrame()
        
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        return view
    }
    
    static var tweetMapStoryboard: UIStoryboard {
        return UIStoryboard(name: "TweetMap", bundle: Bundle.main)
    }
    
    func presentTweetDetailsScreen(from view: TweetsMapViewProtocol, forTweet tweet: TWTRTweet) {
        //let postDetailViewController = PostDetailWireFrame.createPostDetailModule(forPost: post)

        let storyboard = UIStoryboard(name: "TweetDetails", bundle: nil)
        let tweetDetailVC: TweetDetailsViewController = storyboard.instantiateInitialViewController() as! TweetDetailsViewController
        tweetDetailVC.tweet = tweet
        
        if let sourceView = view as? UIViewController {
            sourceView.parent?.navigationController?.pushViewController(tweetDetailVC, animated: true)
        }
    }
}
