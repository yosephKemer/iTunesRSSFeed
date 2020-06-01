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
    
    func fetchRSS(_ feedType: FeedType.RawValue) {
        
        let rssUrl = "https://rss.itunes.apple.com/api/v1/us/apple-music/\(feedType)/all/100/explicit.json"
        print(rssUrl)
        delegate?.showLoadingIndicator()
        NetworkManager.shared.fetchData(url: rssUrl) { [weak self](results) in
            self?.delegate?.hideLoadingIndicator()
            switch results {
                
            case .success(let rssResult):
                self?.model = rssResult
                
                print("rssResult22222", rssResult)
                
            case .failure(_):
                print("Errror was here")
            }
            
            self?.delegate?.fetchRssCallBack(status: true, message: "Error ...")
        }
    }
}
