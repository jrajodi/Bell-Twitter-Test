//
//  UIViewController.swift
//  Bell-Twitter-Test
//
//  Created by Jigs on 2019-09-29.
//  Copyright © 2019 Jignesh Rajodiya. All rights reserved.
//

import UIKit

extension UIViewController {
    
    class var storyboardId: String {
        return "\(self)"
    }
    
    func showAlert(_ title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func getLoadingAlert() -> UIAlertController {
        
        let alertController = UIAlertController(title: nil, message: Strings.loadingText.localized, preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        alertController.view.addSubview(loadingIndicator)
        return alertController
    }

    func show(_ loadingSpinner: UIAlertController) {
        
        if !loadingSpinner.isBeingPresented {
            present(loadingSpinner, animated: true, completion: nil)
        }
    }
    
    func hide() {
        dismiss(animated: true, completion: nil)
    }
    
    func getRadius() -> Int {
        return Defaults.shared.getInt(SettingsConstants.radius) == 0 ? 50 : Defaults.shared.getInt(SettingsConstants.radius)
    }
}
