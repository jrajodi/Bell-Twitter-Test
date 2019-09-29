//
//  Tweet.swift
//  Bell-Twitter-Test
//
//  Created by Jigs on 2019-09-28.
//  Copyright © 2019 Jignesh Rajodiya. All rights reserved.
//

import Foundation

struct Tweet: Decodable {
    
    // MARK: - Properties
    var id: Int = 0
    var text: String?
    var name: String = ""
    var displayName: String?
    var profileImage: String?
    var place: Place?
    
    // MARK: - Enums
    enum CodingKeys: String, CodingKey {
        
        case id
        case text
        case user
        case displayName = "screen_name"
        case name
        case profileImage = "profile_image_url_https"
        case place
    }
    
    // MARK: - Decoder for parsing the data into your Custom Model
    init(from decoder: Decoder) throws {
        
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try values.decode(Int.self, forKey: .id)
            self.text = try values.decode(String.self, forKey: .text)
            self.place = try values.decode(Place.self, forKey: .place)
            
            let user = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .user)
            self.displayName = try user.decode(String.self, forKey: .displayName)
            self.name = try user.decode(String.self, forKey: .name)
            
            let profile = try user.decode(String.self, forKey: .profileImage)
            self.profileImage =  profile.replacingOccurrences(of: "_normal", with: "")
            
        } catch {
            print("Twitter - \(error)")
        }
    }
}
