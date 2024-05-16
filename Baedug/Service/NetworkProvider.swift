//
//  NetworkProvider.swift
//  Baedug
//
//  Created by 정성윤 on 2024/05/16.
//

import Foundation

final class NetworkProvider {
    private let endpoint : String
    init(endpoint: String) {
        self.endpoint = endpoint
    }
    //카테고리 만들기
    public func postDirectory() -> PostDirectoryNetwork {
        let network = Network<PostDirectoryRequestModel>(endpoint)
        return PostDirectoryNetwork(network: network)
    }
}
