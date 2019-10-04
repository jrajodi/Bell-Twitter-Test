//
//  TweetsDetailsView.swift
//  Bell-Twitter-Test
//
//  Created by Jigs on 2019-10-03.
//  Copyright © 2019 Jignesh Rajodiya. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import TwitterKit
import CoreLocation

class TweetsDetailsView: UIViewController {

    @IBOutlet weak var tweetContainerView: UIView!
    @IBOutlet weak var btnReTweet: UIButton!
    @IBOutlet weak var btnFavorite: UIButton!
    
    var presenter: TweetsDetailsPresenterProtocol?
    var tweet: TWTRTweet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.showTweetDetailsView()
    }
    
    private func setupView() {
        self.title = "Tweet Details"
        
        btnFavorite.setRoundCorner()
        btnReTweet.setRoundCorner()
    }
}

extension TweetsDetailsView: TweetsDetailsViewProtocol {
    func showTweetDetailsView(with tweet: TWTRTweet) {
        self.tweet = tweet
        let twitterView = TWTRTweetView(tweet: tweet, style: TWTRTweetViewStyle.compact)
        twitterView.backgroundColor = .clear
        tweetContainerView.addSubview(twitterView)
        
        twitterView.translatesAutoresizingMaskIntoConstraints = false
        twitterView.topAnchor.constraint(equalTo: tweetContainerView.topAnchor).isActive = true
        twitterView.leftAnchor.constraint(equalTo: tweetContainerView.leftAnchor).isActive = true
        twitterView.rightAnchor.constraint(equalTo: tweetContainerView.rightAnchor).isActive = true
        twitterView.bottomAnchor.constraint(equalTo: tweetContainerView.bottomAnchor).isActive = true
    }
}

extension TweetsDetailsView {
    
    @IBAction func actionMakeFavorite(_ sender: UIButton) {
        if (TWTRTwitter.sharedInstance().sessionStore.hasLoggedInUsers()) {
            markFavourite()
        } else {
            TWTRTwitter.sharedInstance().logIn(completion: { (session, error) in
                if session != nil {
                    self.markFavourite()
                } else {
                    self.showAlert(Strings.errorTitle.localized, message: Strings.loginErrorMessage.localized)
                }
            })
        }
    }
    
    @IBAction func actionReTweet(_ sender: UIButton) {
        if (TWTRTwitter.sharedInstance().sessionStore.hasLoggedInUsers()) {
            retweet()
        } else {
            TWTRTwitter.sharedInstance().logIn(completion: { (session, error) in
                if session != nil {
                    self.retweet()
                } else {
                    self.showAlert(Strings.errorTitle.localized, message: Strings.loginErrorMessage.localized)
                }
            })
        }
    }
}

extension TweetsDetailsView {
    
    private func markFavourite() {
        guard let tweetId = self.tweet?.tweetID else { return }
        APIManager.shared.favoriteTweet(forID: tweetId) { (success) in
            if success {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.showAlert(Strings.successTitle.localized, message:"")
                }
            }
        }
    }
    
    private func retweet() {
        guard let tweetId = self.tweet?.tweetID else { return }
        APIManager.shared.retweet(forTweetRequestId: "99", tweetId: tweetId) { (success) in
            if success {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.showAlert(Strings.successTitle.localized, message:"")
                }
            }
        }
    }
}

