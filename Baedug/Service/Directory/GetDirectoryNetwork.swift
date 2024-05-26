//
//  GetDirectoryNetwork.swift
//  Baedug
//
//  Created by 정성윤 on 2024/05/24.
//

import Foundation
import RxSwift
import RxCocoa

final class GetDirectoryNetwork {
    private let network : Network<GetDirectoryResponseModel>
    init(network: Network<GetDirectoryResponseModel>) {
        self.network = network
    }
    public func getDirectoryNetwork(path: String) -> Observable<GetDirectoryResponseModel>{
        return network.getNetwork(path: path)
    }
}
