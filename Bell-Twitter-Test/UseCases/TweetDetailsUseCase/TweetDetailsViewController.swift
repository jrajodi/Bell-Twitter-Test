//
//  TweetDetailsViewController.swift
//  Bell-Twitter-Test
//
//  Created by Jigs on 2019-09-29.
//  Copyright © 2019 Jignesh Rajodiya. All rights reserved.
//

import UIKit
import TwitterKit

class TweetDetailsViewController: UIViewController {

    @IBOutlet weak var tweetContainerView: UIView!
    @IBOutlet weak var btnReTweet: UIButton!
    @IBOutlet weak var btnFavorite: UIButton!
    
    var tweet: TWTRTweet?
    private var loadingSpinner: UIAlertController!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        self.title = "Tweet Details"
        
        btnFavorite.setRoundCorner()
        btnReTweet.setRoundCorner()
        
        loadingSpinner = getLoadingAlert()
        
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

extension TweetDetailsViewController {
    
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

extension TweetDetailsViewController {
    
    private func markFavourite() {
        guard let tweetId = tweet?.tweetID else { return }
        show(loadingSpinner)
        APIManager.shared.favoriteTweet(forID: tweetId) { (success) in
            self.loadingSpinner.hide()
            if success {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.showAlert(Strings.successTitle.localized, message:"")
                }
            }
        }
    }
    
    private func retweet() {
        guard let tweetId = tweet?.tweetID else { return }
        show(loadingSpinner)
        APIManager.shared.retweet(forTweetRequestId: "99", tweetId: tweetId) { (success) in
            self.loadingSpinner.hide()
            if success {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.showAlert(Strings.successTitle.localized, message:"")
                }
            }
        }
    }
}

