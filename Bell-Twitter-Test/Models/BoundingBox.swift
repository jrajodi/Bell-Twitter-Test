//
//  BoundingBox.swift
//  Bell-Twitter-Test
//
//  Created by Jigs on 2019-09-28.
//  Copyright © 2019 Jignesh Rajodiya. All rights reserved.
//

import Foundation

struct BoundingBox: Decodable {
    
    var coordinates: [[[Double]]]?

    enum CodingKeys: String, CodingKey {
        case coordinates
    }
    
    init(from decoder: Decoder) throws {
        
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            self.coordinates = try values.decode([[[Double]]].self, forKey: .coordinates)
        } catch {
            print("BoundingBox - \(error)")
        }
    }
}
