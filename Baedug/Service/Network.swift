//
//  Network.swift
//  Baedug
//
//  Created by 정성윤 on 2024/05/16.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire
import RxAlamofire

final class Network<T:Decodable> {
    private let endpoint : String
    //GCD
    private let queue : ConcurrentDispatchQueueScheduler
    init(_ endpoint: String) {
        self.endpoint = endpoint
        self.queue = ConcurrentDispatchQueueScheduler(qos: .background)
    }
    //MARK: - Get Method Network
    public func getNetwork(path : String) -> Observable<T> {
        let fullpath = "\(endpoint)\(path)"
        return RxAlamofire.data(.get, fullpath, encoding: JSONEncoding.default, headers: ["Content-Type" : "application/json"])
            .debug()
            .observe(on: queue)
            .map { data -> T in
                return try JSONDecoder().decode(T.self, from: data)
            }
    }
    //MARK: - Post Method Network
    public func postNetwork(path: String, params : [String:Any]) -> Observable<T> {
        let fullpath = "\(endpoint)\(path)"
        return RxAlamofire.data(.post, fullpath, parameters: params, encoding: JSONEncoding.default, headers: ["Contetn-Type" : "application/json"])
            .debug()
            .observe(on: queue)
            .map { data -> T in
                return try JSONDecoder().decode(T.self, from: data)
            }
    }
}
