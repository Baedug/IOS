//
//  GetNoteNetwork.swift
//  Baedug
//
//  Created by 정성윤 on 2024/05/25.
//

import Foundation
import RxSwift
import RxCocoa

final class GetNoteNetwork {
    private let network : Network<AddNoteResponseModel>
    init(network: Network<AddNoteResponseModel>) {
        self.network = network
    }
    public func getNoteNetwork(path: String) -> Observable<AddNoteResponseModel> {
        return network.getNetwork(path: path)
    }
}
