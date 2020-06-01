//
//  RSSModel.swift
//  iTunes_RSS Feed
//
//  Created by Yoseph on 5/24/20.
//  Copyright © 2020 Yoseph. All rights reserved.
//

import Foundation

struct RSSModel: Codable {
    let feed: Feed
}

// MARK: - Feed
struct Feed: Codable {
    let title: String
    let id: String?
    let author: Author
    let links: [Link]
    let copyright, country: String
    let icon: String
    let updated: String?
    let results: [ResultFeed]
}

// MARK: - Author
struct Author: Codable {
    let name: String
    let uri: String?
}

// MARK: - Link
struct Link: Codable {
    let linkSelf: String?
    let alternate: String?

    enum CodingKeys: String, CodingKey {
        case linkSelf = "self"
        case alternate
    }
}

// MARK: - Result
struct ResultFeed: Codable {
    let artistName: String?
    let id: String
    let releaseDate: String?
    let name: String?
    let kind: Kind?
    let copyright, artistID: String?
    let artistURL: String?
    let artworkUrl100: String
    let genres: [Genre]?
    let url: String
    let contentAdvisoryRating: String?

    enum CodingKeys: String, CodingKey {
        case artistName, id, releaseDate, name, kind, copyright
        case artistID = "artistId"
        case artistURL = "artistUrl"
        case artworkUrl100, genres, url, contentAdvisoryRating
    }
}

// MARK: - Genre
struct Genre: Codable {
    let genreID, name: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case genreID = "genreId"
        case name, url
    }
}

enum Kind: String, Codable {
    case album = "album"
}
