//
//  AppleLoginService.swift
//  Baedug
//
//  Created by 정성윤 on 2024/03/08.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire
import SwiftKeychainWrapper
class AppleLoginService {
    static func requestLogin(request : LoginModel) -> Observable<LoginServiceModel> {
        return Observable.create { observer in
            let url = "https://baedug.com/login/oauth2/code/apple?code=\(request.authCode)"
            AF.request(url, method: .post, encoding: JSONEncoding.default, headers: ["Content-Type" : "application/json"])
                .validate()
                .responseDecodable(of: LoginServiceModel.self) { response in
                    print(response.debugDescription)
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
