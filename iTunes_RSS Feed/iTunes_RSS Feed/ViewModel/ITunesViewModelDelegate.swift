//
//  MainViewModelDelegate.swift
//  iTunes_RSS Feed
//
//  Created by Yoseph on 5/24/20.
//  Copyright © 2020 Yoseph. All rights reserved.
//

import Foundation
import UIKit


protocol ITunesViewModelDelegate: class {
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func fetchRssCallBack(status: Bool , message: String)
}


class MainViewModel {
    
    var feedResults: Feed?
    var model : RSSModel?
    weak var delegate: ITunesViewModelDelegate?
    
    func fetchRSS() {
        
        let rssUrl = "https://rss.itunes.apple.com/api/v1/us/apple-music/coming-soon/all/100/explicit.json"
        delegate?.showLoadingIndicator()
        NetworkManager.sharedInstance.apiRequest(url: rssUrl) { [weak self](success, response, errorMessage) in
            
            if success {
                self?.delegate?.hideLoadingIndicator()
                if let responseData = response as? Data {
                    do {
                        let decoder = JSONDecoder()
                        let model = try decoder.decode(RSSModel.self, from: responseData)
                        self?.model = model
                        self?.delegate?.fetchRssCallBack(status: true, message: "")
                        return
                        
                    } catch {
                        print(error.localizedDescription)
                        self?.delegate?.fetchRssCallBack(status: false, message: "Something went wrong")
                        return
                    }
                }
            }
            
            self?.delegate?.fetchRssCallBack(status: true, message: errorMessage ?? "")
        }
        
        
        //        NetworkManager2.shared.iTunesFetch { (results) in
        //            switch results {
        //            case .success(let newResult):
        //                self.model = newResult
        //                self.delegate?.fetchRssCallBack(status: true, message: "")
        //                print("feedResults....", self.feedResults!)
        //            case .failure(_):
        //                print("Error.... in feedResults")
        //            }
        //
        //        }
        
    }
}
