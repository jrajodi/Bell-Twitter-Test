//
//  Place.swift
//  Bell-Twitter-Test
//
//  Created by Jigs on 2019-09-28.
//  Copyright © 2019 Jignesh Rajodiya. All rights reserved.
//

import Foundation

struct Place: Decodable {

    var boundingBox: BoundingBox?
    var fullName: String?
    var country: String?

    enum CodingKeys: String, CodingKey {
        case boundingBox = "bounding_box"
        case fullName = "full_name"
        case country
    }
    
    init(from decoder: Decoder) throws {
        
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            self.fullName = try values.decode(String.self, forKey: .fullName)
            self.country = try values.decode(String.self, forKey: .country)
            self.boundingBox = try values.decode(BoundingBox.self, forKey: .boundingBox)
        } catch {
            print("Place - \(error)")
        }
    }
}
