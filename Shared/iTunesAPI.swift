//
//  iTunesAPI.swift
//  iTunesAPISwiftUI
//
//  Created by Seyfeddin Bassarac on 23.11.2019.
//  Copyright © 2019 ThreadCo. All rights reserved.
//

import Foundation
import Moya
import Alamofire

enum TunesAPI {

    case search(query: String)
}

extension TunesAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://itunes.apple.com/")!
    }

    var path: String {
        switch self {
        case .search:
            return "search"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var sampleData: Data {
        return Data(base64Encoded: "")!
    }

    var task: Task {
        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }

    var headers: [String : String]? {
        return nil
    }

    var parameters: [String: Any] {
        switch self {
        case .search(let query):
            return [
                "term": query,
                "entity": "song"
            ]
        }
    }
}
