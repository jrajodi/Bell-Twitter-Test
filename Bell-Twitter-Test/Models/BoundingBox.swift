//
//  BoundingBox.swift
//  Bell-Twitter-Test
//
//  Created by Jigs on 2019-09-28.
//  Copyright © 2019 Jignesh Rajodiya. All rights reserved.
//

import Foundation

struct BoundingBox: Decodable {
    
    // MARK: - Properties
    var coordinates: [[[Double]]]?
    
    // MARK: - Enum for defining the keys of your response data
    enum CodingKeys: String, CodingKey {
        case coordinates
    }
    
    // MARK: - Decoder for parsing the data into your Custom Model
    init(from decoder: Decoder) throws {
        
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            self.coordinates = try values.decode([[[Double]]].self, forKey: .coordinates)
        } catch {
            print("BoundingBox - \(error)")
        }
    }
}
