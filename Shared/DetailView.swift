//
//  DetailView.swift
//  iTunesAPISwiftUI
//
//  Created by Seyfeddin Bassarac on 25.06.2020.
//  Copyright © 2020 ThreadCo. All rights reserved.
//

import SwiftUI

struct DetailView: View {

    var songTitle: String

    var body: some View {
        Text(songTitle)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(songTitle: "Pull Me Under")
    }
}
