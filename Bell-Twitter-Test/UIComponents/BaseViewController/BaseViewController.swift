//
//  ViewController.swift
//  Bell-Twitter-Test
//
//  Created by Jigs on 2019-09-28.
//  Copyright © 2019 Jignesh Rajodiya. All rights reserved.
//

import UIKit
class BaseViewController: UIViewController {
    private var btnToggleDisplay: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    func initialize() {
        
        self.navigationController?.navigationBar.topItem?.title = "Most Recent Tweets"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
        UINavigationBar.appearance().largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
        
        btnToggleDisplay = UIButton(type: .custom)
        let imageList = UIImage(imageLiteralResourceName: "btn_list")
        let imageMap = UIImage(imageLiteralResourceName: "btn_map")
    
        btnToggleDisplay.tintColor = .black
        btnToggleDisplay.setImage(imageList, for: .normal)
        btnToggleDisplay.setImage(imageMap, for: .selected)
        btnToggleDisplay.isSelected = false
        btnToggleDisplay.addTarget(self, action: #selector(actionToggelTweetsView(_:)), for: .touchUpInside)
        
        showTweetsMapView()

        let rightButtonsView = UIStackView(arrangedSubviews: [btnToggleDisplay])
        rightButtonsView.axis = .horizontal
        rightButtonsView.distribution = .equalSpacing
        rightButtonsView.spacing = 10.0
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButtonsView)
    }
    
    @objc func actionToggelTweetsView(_ sender: UIButton) {
        if sender.isSelected {
            self.navigationController?.navigationBar.topItem?.title = "Most Recent Tweets"
            showTweetsMapView()
            sender.isSelected = false
        } else {
            self.navigationController?.navigationBar.topItem?.title = "Search"
            showTweetsListView()
            sender.isSelected = true
        }
    }
    
    func showTweetsListView() {
        let storyboard = UIStoryboard(name: "TweetsList", bundle: nil)
        let controller: TweetsListViewController = storyboard.instantiateInitialViewController() as! TweetsListViewController
        controller.view.bounds = self.view.bounds;
        controller.willMove(toParent: self)
        self.view.addSubview(controller.view)
        self.addChild(controller)
        controller.didMove(toParent: self)
    }
    
    func showTweetsMapView() {
        let storyboard = UIStoryboard(name: "TweetsMap", bundle: nil)
        let controller: TweetsMapViewController = storyboard.instantiateInitialViewController() as! TweetsMapViewController
        controller.view.bounds = self.view.bounds;
        controller.willMove(toParent: self)
        self.view.addSubview(controller.view)
        self.addChild(controller)
        controller.didMove(toParent: self)
    }
}
