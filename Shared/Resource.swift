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
    var value: [Track]? {
        didSet {
            objectWillChange.send(value ?? [])
        }
    }
    var query: String = ""
    var isLoading = false {
        didSet {
            objectWillChange.send(value ?? [])
        }
    }

    var objectWillChange: PassthroughSubject<[Track], Never> = PassthroughSubject()

    var storage = Set<AnyCancellable>()

    func search(query: String) {

        self.query = query

        isLoading = true

        var components = URLComponents(string: "https://itunes.apple.com/")!
        components.path = "/search"
        var queryItems: [URLQueryItem] = []
        queryItems.append(URLQueryItem(name: "entity", value: "song"))
        queryItems.append(URLQueryItem(name: "term", value: query))
        components.queryItems = queryItems
        let request = URLRequest(url: components.url!)
        print(request)

        URLSession.shared.dataTaskPublisher(for: request)
            .map {
                $0.data
            }
            .tryMap({ (data) -> JSONDecoder.Input in
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    return try JSONSerialization.data(withJSONObject: jsonObject["results"] ?? jsonObject, options: [.prettyPrinted])
                } catch {
                    throw error
                }
            })
            .decode(type: [Track].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                self.isLoading = false
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    print("finished request successfully")
                }
            } receiveValue: { tracks in
                self.value = tracks
            }.store(in: &storage)
    }
}
