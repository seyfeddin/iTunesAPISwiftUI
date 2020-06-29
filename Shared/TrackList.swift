//
//  TrackList.swift
//  iTunesAPISwiftUI
//
//  Created by Seyfeddin Bassarac on 23.11.2019.
//  Copyright © 2019 ThreadCo. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct TrackList: View {

    var tracks: [Track]

    @Binding var searchText: String

    var commitBlock: (String) -> ()

    var body: some View {
        List {
            SearchBarItem(searchText: $searchText, commitBlock: commitBlock)
            if tracks.isEmpty {
                Text("Enter a search query to start")
                    .padding()
            } else {
                ForEach(tracks) { track in
                    NavigationLink(destination: DetailView(songTitle: track.trackName)) {
                        ListItem(track: track)
                    }
                }
            }
        }
    }
}

struct TrackList_Previews: PreviewProvider {

    static var previews: some View {

        ListItem(track: Track(trackID: 1, artistName: "Ezhel",
        collectionName: "Müptezhel", trackName: "Geceler", previewUrl: "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview118/v4/4b/15/a0/4b15a06d-4b5d-7099-1e0e-354300be5899/mzaf_9014807440103508832.plus.aac.p.m4a", artworkUrl60: "https://is2-ssl.mzstatic.com/image/thumb/Music128/v4/f0/e1/16/f0e116a9-2579-7c25-9cca-ff550510bfb8/source/60x60bb.jpg", artworkUrl100: "https://is2-ssl.mzstatic.com/image/thumb/Music128/v4/f0/e1/16/f0e116a9-2579-7c25-9cca-ff550510bfb8/source/100x100bb.jpg")
        ).previewLayout(PreviewLayout.fixed(width: 250, height: 75))
    }
}

struct ListItem: View {

    var track: Track

    var body: some View {
        HStack(alignment: .center, spacing: 12.0, content: {
            WebImage(url: URL(string: track.artworkUrl60)!)
                .resizable()
                .aspectRatio(1.0, contentMode: .fill)
                .frame(width: 48, height: 48, alignment: .leading)
                .clipShape(RoundedRectangle(cornerRadius: 12.0))
                .shadow(radius: 2)
            VStack {
                VStack(alignment: .leading, spacing: 2.0, content: {
                    Text(track.trackName)

                        .foregroundColor(Color(white: 0.1))
                        .font(/*@START_MENU_TOKEN@*/.headline/*@END_MENU_TOKEN@*/)
                    Text(track.collectionName)
                        .font(.caption)
                        .foregroundColor(Color(white: 0.3))
                })
            }
        })
            .padding()
    }
}

struct SearchBarItem: View {

    @Binding var searchText: String

    var commitBlock: (String) -> ()

    var body: some View {
        Color(.sRGB, white: 1.0, opacity: 1.0)
            .overlay(SearchBar(searchText: $searchText, commitBlock: commitBlock))
            .cornerRadius(5.0)
            .listRowBackground(Color(.sRGB, white: 0.95, opacity: 1.0))
    }
}

