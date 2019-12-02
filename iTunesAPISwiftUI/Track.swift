//
//  Track.swift
//  iTunesAPISwiftUI
//
//  Created by Seyfeddin Bassarac on 23.11.2019.
//  Copyright © 2019 ThreadCo. All rights reserved.
//

import Foundation
import Combine

class Track: Codable, Identifiable {

    enum CodingKeys: String, CodingKey {
        case trackID = "trackId"
        case artistName
        case collectionName
        case trackName
        case previewUrl
        case artworkUrl60
        case artworkUrl100
    }

    var trackID: Int
    var artistName: String
    var collectionName: String
    var trackName: String
    var previewUrl: String
    var artworkUrl60: String
    var artworkUrl100: String

    init(
        trackID: Int,
        artistName: String,
        collectionName: String,
        trackName: String,
        previewUrl: String,
        artworkUrl60: String,
        artworkUrl100: String
    ) {
        self.trackID = trackID
        self.artistName = artistName
        self.collectionName = collectionName
        self.trackName = trackName
        self.previewUrl = previewUrl
        self.artworkUrl60 = artworkUrl60
        self.artworkUrl100 = artworkUrl100
    }

    var id: Int {
        return trackID
    }
}
