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
        self.endpoint = endpointURL
    }
    //MARK: - Directory
    //디렉토리 생성
    public func postDirectory() -> PostDirectoryNetwork {
        let network = Network<PostDirectoryResponseModel>(endpoint)
        return PostDirectoryNetwork(network: network)
    }
    //디렉토리 조회
    public func getDirectory() -> GetDirectoryNetwork {
        let network = Network<GetDirectoryResponseModel>(endpoint)
        return GetDirectoryNetwork(network: network)
    }
    //디렉토리 내 노트 조회
    public func getDetail() -> GetDetailNetwork {
        let network = Network<GetDetailResponseModel>(endpoint)
        return GetDetailNetwork(network: network)
    }
    //MARK: - Heart
    public func postHeart() -> PostHeartNetwork {
        let network = Network<PostHeartResponseModel>(endpoint)
        return PostHeartNetwork(network: network)
    }
    public func getHeart() -> GetHeartNetwork {
        let network = Network<MainResponseModel>(endpoint)
        return GetHeartNetwork(network: network)
    }
    //MARK: - Note
    //노트 생성
    public func postNote() -> PostNoteNetwork {
        let network = Network<AddNoteResponseModel>(endpoint)
        return PostNoteNetwork(network: network)
    }
}
