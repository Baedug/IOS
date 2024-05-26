//
//  GetHeartNetwork.swift
//  Baedug
//
//  Created by 정성윤 on 2024/05/24.
//

import Foundation
import RxSwift
import RxCocoa

final class GetHeartNetwork {
    private let network : Network<MainResponseModel>
    init(network: Network<MainResponseModel>) {
        self.network = network
    }
    public func getHeartNetwork(path: String) -> Observable<MainResponseModel> {
        return network.getNetwork(path: path)
    }
}
