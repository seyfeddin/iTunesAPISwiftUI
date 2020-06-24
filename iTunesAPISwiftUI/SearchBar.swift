//
//  SearchBar.swift
//  iTunesAPISwiftUI
//
//  Created by Seyfeddin Bassarac on 25.06.2020.
//  Copyright © 2020 ThreadCo. All rights reserved.
//

import SwiftUI

struct SearchBar : View {
    @Binding var searchText: String

    var commitBlock: (String) -> ()

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass").foregroundColor(.secondary)
            TextField("Search",
                      text: $searchText,
                      onEditingChanged: { (didChange) in
                      },
                      onCommit: {
                        commitBlock(searchText)

                           UIApplication.shared.keyWindow?.endEditing(true)
                      })
            Button(action: {
                self.searchText = ""
            }) {
                Image(systemName: "xmark.circle.fill").foregroundColor(.secondary).opacity(searchText == "" ? 0 : 1)
            }
        }.padding(.horizontal)
    }
}
