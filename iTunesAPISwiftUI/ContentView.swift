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

    var body: some View {
        NavigationView {
            Group {
                if resource.value == nil {
                    Text("Yükleniyor…")
                } else {
                    TrackList(tracks: resource.value ?? [])
                }
            }.navigationBarTitle(resource.query).navigationBarItems(
                trailing:                     SearchBar(searchText: $resource.query, commitBlock: { query in
                    resource.search(query: query)
                })
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
