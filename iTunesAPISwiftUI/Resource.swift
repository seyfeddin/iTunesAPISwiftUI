//
//  Resource.swift
//  iTunesAPISwiftUI
//
//  Created by Seyfeddin Bassarac on 2.12.2019.
//  Copyright © 2019 ThreadCo. All rights reserved.
//

import Foundation
import Combine

final class Resource: ObservableObject {
    var endpoint: TunesAPI
    var value: [Track]? {
        didSet {
            if let value = value {
                DispatchQueue.main.async {
                    self.objectWillChange.send(value)
                }
            }
        }
    }
    var query: String = "" {
        didSet {
            endpoint = .search(query: query)
        }
    }

    var objectWillChange: PassthroughSubject<[Track], Never> = PassthroughSubject()

    init(endpoint: TunesAPI) {
        self.endpoint = endpoint
        reload()
    }

    func search(query: String) {

        self.query = query

        TunesNetwork.request(
            target: endpoint,
            success: { (data) in

                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    let resultsData = try JSONSerialization.data(withJSONObject: jsonObject["results"]!, options: [.prettyPrinted])
                    let tracks = try JSONDecoder().decode([Track].self, from: resultsData)
                    self.value = tracks
                } catch {
                    print(error)
                }
        }, error: { (errorString, statusCode) in

        }) { (error) in

        }
    }

    func reload() {
        TunesNetwork.request(
            target: endpoint,
            success: { (data) in

                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    let resultsData = try JSONSerialization.data(withJSONObject: jsonObject["results"]!, options: [.prettyPrinted])
                    let tracks = try JSONDecoder().decode([Track].self, from: resultsData)
                    self.value = tracks
                } catch {
                    print(error)
                }
        }, error: { (errorString, statusCode) in

        }) { (error) in

        }
    }
}
