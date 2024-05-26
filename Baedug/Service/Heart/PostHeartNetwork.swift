//
//  PostHeartNetwork.swift
//  Baedug
//
//  Created by 정성윤 on 2024/05/24.
//

import Foundation
import RxCocoa
import RxSwift

final class PostHeartNetwork {
    private let network : Network<PostHeartResponseModel>
    init(network: Network<PostHeartResponseModel>) {
        self.network = network
    }
    public func postHeartNetwork(path: String, params : [String:Any]) -> Observable<PostHeartResponseModel> {
        return network.postNetwork(path: path, params: params)
    }
}
