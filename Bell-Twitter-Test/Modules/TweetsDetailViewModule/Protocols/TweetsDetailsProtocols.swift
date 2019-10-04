//
//  TweetsDetailsProtocols.swift
//  Bell-Twitter-Test
//
//  Created by Jigs on 2019-10-03.
//  Copyright © 2019 Jignesh Rajodiya. All rights reserved.
//

import Foundation
import UIKit
import TwitterKit

protocol TweetsDetailsViewProtocol: class {
    var presenter: TweetsDetailsPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func showTweetDetailsView(with tweet: TWTRTweet)
}

protocol TweetsDetailsWireFrameProtocol: class {
    static func createTweetsDetailsViewModule(forTweet tweet: TWTRTweet) -> UIViewController
}

protocol TweetsDetailsPresenterProtocol: class {
    var view: TweetsDetailsViewProtocol? { get set }
    var wireFrame: TweetsDetailsWireFrameProtocol? { get set }
    var tweet: TWTRTweet? { get set }
    
    // VIEW -> PRESENTER
    func showTweetDetailsView()
}
