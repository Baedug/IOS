//
//  PostDirectoryNetwork.swift
//  Baedug
//
//  Created by 정성윤 on 2024/05/16.
//

import Foundation
import RxSwift
import RxCocoa

final class PostDirectoryNetwork {
    private let network : Network<PostDirectoryRequestModel>
    init(network: Network<PostDirectoryRequestModel>) {
        self.network = network
    }
    public func postDirectory(path: String, params: [String:Any]) -> Observable<PostDirectoryRequestModel> {
        return network.postNetwork(path: path, params: params)
    }
}
