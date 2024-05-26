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
import SwiftKeychainWrapper

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
        let accessToken = KeychainWrapper.standard.string(forKey: "JWTaccessToken") ?? ""
        return Observable.create { observer in
            AF.request(fullpath, method: .get, headers: ["Content-Type" : "application/json", "Authorization" : "\(accessToken)"])
                .validate()
                .responseDecodable(of: T.self) { response in
                    print("\(response.debugDescription)")
                    switch response.result {
                    case .success(let data):
                        observer.onNext(data)
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
            return Disposables.create()
        }
    }
    //MARK: - Post Method Network
    public func postNetwork(path: String, params : [String:Any]) -> Observable<T> {
        let fullpath = "\(endpoint)\(path)"
        let accessToken = KeychainWrapper.standard.string(forKey: "JWTaccessToken") ?? ""
        return Observable.create { observer in
            AF.request(fullpath, method: .post, parameters: params, encoding: JSONEncoding.default, headers: ["Content-Type" : "application/json", "Authorization" : "\(accessToken)"])
                .validate()
                .responseDecodable(of: T.self) { response in
                    print("\(response.debugDescription)")
                    switch response.result {
                    case .success(let data):
                        observer.onNext(data)
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
            return Disposables.create()
        }
    }
}
