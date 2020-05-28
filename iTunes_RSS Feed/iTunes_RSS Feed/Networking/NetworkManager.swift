//
//  NetworkingManager.swift
//  iTunes_RSS Feed
//
//  Created by Yoseph on 5/24/20.
//  Copyright © 2020 Yoseph. All rights reserved.
//

import Foundation
import UIKit

typealias APIResult = (Bool,Any?,String?) -> ()


class NetworkManager: NSObject {
    static var sharedInstance = NetworkManager()
    
    //MARK: - Public Methods
    public func apiRequest(url:String, completion:@escaping APIResult) {
        
        let defaultSession = URLSession(configuration: .default)
        guard let url = URL(string: url) else {
            completion(false, nil, "Something went wrong.")
            return
        }
        
        let task = defaultSession.dataTask(with: url, completionHandler: { (data,response,error) in
            
            if let urlResponse = response as? HTTPURLResponse,
                (200..<300).contains(urlResponse.statusCode) {
                completion(true, data, "")
                
            } else {
                completion(false, nil, "Something went wrong.")
            }
        })
        task.resume()
    }
}
