//
//  ImageLoader.swift
//  iTunes_RSS Feed
//
//  Created by Yoseph on 5/24/20.
//  Copyright © 2020 Yoseph. All rights reserved.
//

import Foundation
import UIKit

class ImageLoader {
    
    var task: URLSessionDownloadTask?
    var session: URLSession?
    var cache: NSCache<NSString, UIImage>?
    
    init() {
        session = URLSession.shared
       //task = URLSessionDownloadTask()
        self.cache = NSCache()
    }
    
    func obtainImageWithPath(imageName: String, imageURL: String, completionHandler: @escaping (UIImage?) -> ()) {
        if let image = self.cache?.object(forKey: imageName as NSString) {
            DispatchQueue.main.async {
                completionHandler(image)
            }
        } else {
            let placeholder = UIImage(named: "headphones")
            DispatchQueue.main.async {
                completionHandler(placeholder)
            }
            guard let url = URL(string: imageURL) else {return}
            task = session?.downloadTask(with: url, completionHandler: { (location, response, error) in
                if let data = try? Data(contentsOf: url) {
                    guard let img = UIImage(data: data) else {return}
                    self.cache?.setObject(img, forKey: imageName as NSString)
                    DispatchQueue.main.async {
                        completionHandler(img)
                    }
                }
            })
            task?.resume()
        }
    }
}
