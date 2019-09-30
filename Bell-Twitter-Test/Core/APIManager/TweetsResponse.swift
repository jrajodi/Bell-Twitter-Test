//
//  TweetsResponse.swift
//  Bell-Twitter-Test
//
//  Created by Jigs on 2019-09-28.
//  Copyright © 2019 Jignesh Rajodiya. All rights reserved.
//

import Foundation

struct TweetsResponse: Decodable {

    var tweets: [Tweet] = [Tweet]()

    enum CodingKeys: String, CodingKey {
        case tweets = "statuses"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        do {
            tweets = try values.decode([Tweet].self, forKey: .tweets)
        } catch {
            print("something wrong while parsing response")
        }
    }
}
