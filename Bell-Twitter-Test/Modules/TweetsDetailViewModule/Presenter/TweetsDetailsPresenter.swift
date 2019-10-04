//
//  TweetsDetailsPresenter.swift
//  Bell-Twitter-Test
//
//  Created by Jigs on 2019-10-03.
//  Copyright © 2019 Jignesh Rajodiya. All rights reserved.
//

import Foundation
import TwitterKit

class TweetsDetailsPresenter: TweetsDetailsPresenterProtocol {
    weak var view: TweetsDetailsViewProtocol?
    var wireFrame: TweetsDetailsWireFrameProtocol?
    var tweet: TWTRTweet?

    func showTweetDetailsView() {
        view?.showTweetDetailsView(with: tweet!)
    }
}
