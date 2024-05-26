//
//  PostNoteNetwork.swift
//  Baedug
//
//  Created by 정성윤 on 2024/05/25.
//

import Foundation
import RxSwift
import RxCocoa

final class PostNoteNetwork {
    private let network : Network<AddNoteResponseModel>
    init(network: Network<AddNoteResponseModel>) {
        self.network = network
    }
    public func postNoteNetwork(path: String, params : [String:Any]) -> Observable<AddNoteResponseModel> {
        return network.postNetwork(path: path, params: params)
    }
}
