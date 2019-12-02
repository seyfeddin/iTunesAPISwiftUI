//
//  iTunesNetwork.swift
//  iTunesAPISwiftUI
//
//  Created by Seyfeddin Bassarac on 23.11.2019.
//  Copyright © 2019 ThreadCo. All rights reserved.
//

import Moya

struct TunesNetwork {

    @discardableResult static func request(
        target: TunesAPI,
        success successCallback: @escaping (Data) -> Void,
        error errorCallback: @escaping (_ message : String, _ statusCode: Int) -> Void,
        failure failureCallback: @escaping (MoyaError) -> Void
        ) -> Cancellable {

        let pluginsArray:[PluginType] = [NetworkLoggerPlugin(cURL: true)]
        let provider = MoyaProvider<TunesAPI>(plugins: pluginsArray)

        return provider.request(target) { (result) in

            switch result {
            case let .success(response):
                do {
                    _ = try response.filterSuccessfulStatusCodes()
                    successCallback(response.data)
                } catch MoyaError.statusCode(let response) {
                    errorCallback("Hata", response.statusCode)
                } catch {
                    errorCallback("Hata", response.statusCode)
                }
            case let .failure(error):

                failureCallback(error)
            }
        }
    }

}
