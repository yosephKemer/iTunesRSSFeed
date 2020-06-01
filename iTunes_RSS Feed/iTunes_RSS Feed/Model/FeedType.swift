//
//  FeedType.swift
//  iTunes_RSS Feed
//
//  Created by Yosef on 6/1/20.
//  Copyright © 2020 Yoseph. All rights reserved.
//

import Foundation

enum FeedType: String, Codable {
    case comingSoon = "coming-soon"
    case newReleases = "new-releases"
    case topAlbums = "top-albums"
    
}
