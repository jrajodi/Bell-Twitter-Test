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

class TweetsDetailsWireFrame: TweetsDetailsWireFrameProtocol {
    class func createTweetsDetailsViewModule(forTweet tweet: TWTRTweet) -> UIViewController {
        let view: TweetsDetailsView = tweetDetailsStoryboard.instantiateInitialViewController() as! TweetsDetailsView
        
        let presenter: TweetsDetailsPresenterProtocol = TweetsDetailsPresenter()
        let wireFrame: TweetsDetailsWireFrameProtocol = TweetsDetailsWireFrame()
        
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.tweet = tweet
        return view
    }
    
    static var tweetDetailsStoryboard: UIStoryboard {
        return UIStoryboard(name: "TweetsDetails", bundle: Bundle.main)
    }
}
