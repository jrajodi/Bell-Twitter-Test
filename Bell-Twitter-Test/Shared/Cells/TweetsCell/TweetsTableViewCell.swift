//
//  TweetsTableViewCell.swift
//  Bell-Twitter-Test
//
//  Created by Jigs on 2019-09-29.
//  Copyright © 2019 Jignesh Rajodiya. All rights reserved.
//

import UIKit

class TweetsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ivProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDisplayName: UILabel!
    @IBOutlet weak var lblTweet: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ivProfile.setRoundCorner()
        containerView.setCornerRadius(5)
    }
}

extension TweetsTableViewCell: ConfigureCell {
    
    typealias T = Tweet
    func configureCell(_ data: Tweet) {
        lblName.text = data.name
        lblDisplayName.text =  "@" + (data.displayName ?? "")
        lblTweet.text = data.text
        
        ivProfile.loadImage(url: URL(string: data.profileImage ?? "")!)
    }
}

