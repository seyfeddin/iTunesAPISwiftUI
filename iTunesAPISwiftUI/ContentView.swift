//
//  ContentView.swift
//  iTunesAPISwiftUI
//
//  Created by Seyfeddin Bassarac on 23.11.2019.
//  Copyright © 2019 ThreadCo. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {

    @ObservedObject var resource: Resource = Resource(endpoint: .search(query: ""))

    let progressStyle: CircularProgressViewStyle = CircularProgressViewStyle(tint: .black)

    var body: some View {
        NavigationView {
            Group {
                if resource.isLoading {
                    ProgressView().progressViewStyle(progressStyle)
                } else {
                    TrackList(
                        tracks: resource.value ?? [],
                        searchText: $resource.query,
                    commitBlock: { query in
                        resource.search(query: query)
                    })
                }
            }.navigationBarTitle(resource.query.isEmpty ? "iTunes API" : resource.query, displayMode: resource.query.isEmpty ? .inline : .large)

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
