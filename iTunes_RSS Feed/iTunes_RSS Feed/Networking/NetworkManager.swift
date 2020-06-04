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


class NetworkManager {

    static let shared = NetworkManager()

    func fetchData(url: String, completion: @escaping (Result<RSSModel, NetworkError>) -> ()) {
        print("service call started.....")

        guard let url = URL(string: url) else { return }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in

            if let error = error {
                print("Failed to fetch apps:", error)
                completion(.failure(.urlFailure ))
                return
            }

            guard let data = data else {
                completion(.failure(.wrongData))
                return }

            do {
                let decoder = JSONDecoder()
                let rssResponse = try decoder.decode(RSSModel.self, from: data)
           
                completion(.success(rssResponse))
            } catch let jsonErr {
                print("Failed to decode json:", jsonErr)
                completion(.failure(.decodingFailure))
            }
        }
        task.resume()
    }
}

enum NetworkError: Error {
    case urlFailure
    case decodingFailure
    case wrongData
    case imageDownloadError
}
