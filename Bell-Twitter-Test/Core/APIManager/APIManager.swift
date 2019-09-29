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
    
    // Parameters of your request
    private struct NetworkParameter {
        
        static let tweetRequestId = "tweetRequestId"
        static let tweetId = "tweetId"
        static let id = "id"
    }
    
    // Shared Instance of APIManager
    static let shared = APIManager()
    
    /** Search the tweets based on radius, keyword and location
     * - Parameters: radius
     * - Parameters: keyword
     * - Parameters: completion to return your async response
     */
    func searchWithRadius(_ radius: Int, keyword: String, completion: @escaping (TweetsResponse?) -> (Void)) {
        
        var  query = keyword
        let location = LocationManager.sharedInstance.lastLocation
        let geocode = "\(location?.coordinate.latitude ?? 43.648065),\(location?.coordinate.longitude ?? -79.420417),\(radius)km"
        query = query.urlEscaped
        let queryURL = "\(APIEndPoints.baseURL)search/tweets.json?count=100&q=\(query)&result_type=mixed&geocode=\(geocode)"
        
        let request = URLRequest(url: URL(string: queryURL)!)
        TWTRAPIClient().sendTwitterRequest(request) { (response, data, err) in
            
            print(data?.prettyPrintedJSONString! ?? "")
            
            if let result = try? JSONDecoder().decode(TweetsResponse.self, from: data!) {
                completion(result)
            } else {
                completion(nil)
            }
        }
    }
    
    /** Search the tweets based on keyword and location
     * - Parameters: keyword
     * - Parameters: completion to return your async response
     */
    func searchTweetsWith(_ keyword: String, completion: @escaping (TweetsResponse?) -> (Void)) {
        
        var  query = keyword
        query = query.urlEscaped
        let queryURL = "\(APIEndPoints.baseURL)search/tweets.json?count=100&q=\(query)&result_type=mixed"
        
        let request = URLRequest(url: URL(string: queryURL)!)
        TWTRAPIClient().sendTwitterRequest(request) { (response, data, err) in
            
            print(data?.prettyPrintedJSONString! ?? "")
            if let result = try? JSONDecoder().decode(TweetsResponse.self, from: data!) {
                completion(result)
            } else {
                completion(nil)
            }
        }
    }
    
    /** Fetch tweet details based on tweetId
     * - Parameters: tweetId
     * - Parameters: completion to return your async response
     */
    func fetchTweetDetail(tweetId: Int, completion: @escaping (TWTRTweet?, Error?) -> (Void)) {
        
        TWTRAPIClient().loadTweet(withID: "\(tweetId)") { (tweet, error) in
            completion(tweet, error)
        }
    }
    
    /** Make retweet the current tweet
     * - Parameters: tweetRequestId
     * - Parameters: tweetId
     * - Parameters: completion to return your async response
     */
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
    
    /** Make the tweet favorite
     * - Parameters: id
     * - Parameters: completion to return your async response
     */
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
