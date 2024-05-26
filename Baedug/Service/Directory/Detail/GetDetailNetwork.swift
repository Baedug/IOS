//
//  GetDetailNetwork.swift
//  Baedug
//
//  Created by 정성윤 on 2024/05/26.
//

import Foundation
import RxSwift
import RxCocoa

//디렉토리 내 노트 조회
final class GetDetailNetwork {
    private let network : Network<GetDetailResponseModel>
    init(network: Network<GetDetailResponseModel>) {
        self.network = network
    }
    public func getDetailNetwork(path: String) -> Observable<GetDetailResponseModel> {
        return network.getNetwork(path: path)
    }
}
