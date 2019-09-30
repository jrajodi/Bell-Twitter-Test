//
//  APIManager.swift
//  Bell-Twitter-Test
//
//  Created by Jigs on 2019-09-28.
//  Copyright © 2019 Jignesh Rajodiya. All rights reserved.
//

import Foundation
import Alamofire
import TwitterKit

class APIManager {
    
    let apiClient = TWTRAPIClient()

    private struct NetworkParameter {
        static let tweetRequestId = "tweetRequestId"
        static let tweetId = "tweetId"
        static let id = "id"
    }
    
    private struct SearchResultType {
        static let mixed = "mixed"
        static let recent = "recent"
        static let popular = "popular"
    }
    
    static let shared = APIManager()
    
    func searchWithRadius(_ radius: Int, completion: @escaping (TweetsResponse?) -> (Void)) {
        let location = LocationManager.sharedInstance.lastLocation
        let geocode = "\(location?.coordinate.latitude ?? 45.494862),\(location?.coordinate.longitude ?? -73.580650),\(radius)km"
        let params = [
            "geocode": geocode,
            "count": "100",
            "q": "#montreal",
            "result_type": SearchResultType.recent
        ]
        let request = apiClient.urlRequest(withMethod: "GET", urlString: APIPath.search.url, parameters: params, error: nil)
        apiClient.sendTwitterRequest(request) { (response, data, err) in

            print(data?.prettyPrintedJSONString! ?? "")

            if let result = try? JSONDecoder().decode(TweetsResponse.self, from: data ?? Data()) {
                completion(result)
            } else {
                completion(nil)
            }
        }
    }
    
    func searchTweetsWith(_ keyword: String, completion: @escaping (TweetsResponse?) -> (Void)) {
        let params = [
            "q": keyword.urlEscaped,
            "result_type": SearchResultType.mixed
        ]
        let request = apiClient.urlRequest(withMethod: "GET", urlString: APIPath.search.url, parameters: params, error: nil)
        TWTRAPIClient().sendTwitterRequest(request) { (response, data, err) in
            
            print(data?.prettyPrintedJSONString! ?? "")
            if let result = try? JSONDecoder().decode(TweetsResponse.self, from: data!) {
                completion(result)
            } else {
                completion(nil)
            }
        }
    }
    
    func fetchTweetDetail(tweetId: Int, completion: @escaping (TWTRTweet?, Error?) -> (Void)) {
        TWTRAPIClient().loadTweet(withID: "\(tweetId)") { (tweet, error) in
            completion(tweet, error)
        }
    }
    
    func retweet(forTweetRequestId tweetRequestId: String, tweetId: String, completion: @escaping (Bool) -> Void) {
        
        let urlString = APIPath.postedTweet.url
        let parameters = [
            NetworkParameter.tweetRequestId: tweetRequestId,
            NetworkParameter.tweetId: tweetId
        ]
        
        Alamofire.request(urlString, method: .post, parameters: parameters).responseString { response in
            completion(response.result.isSuccess)
        }
    }

    func favoriteTweet(forID id: String, completion: @escaping (Bool) -> Void) {
        
        let urlString = APIPath.favorite.url
        let parameters = [
            NetworkParameter.id: id,
        ]
        
        Alamofire.request(urlString, method: .post, parameters: parameters).responseString { response in
            print("response: \(String(describing: response.data?.prettyPrintedJSONString))")
            completion(response.result.isSuccess)
        }
    }
}
