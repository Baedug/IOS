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
    static func requestLogin(request : LoginModel) -> Observable<Void> {
        return Observable.create { observer in
            let url = "https://baedug.com/login/oauth2/code/apple?code=\(request.authCode)"
            AF.request(url, method: .post, encoding: JSONEncoding.default, headers: ["Content-Type" : "application/json"])
                .validate()
                .response() { response in
                    switch response.result {
                    case .success(let data):
                        if let utf8String = String(data: data!, encoding: .utf8) {
                            print("통신 결과 : \(utf8String)")
                        } else {
                            print("Failed to decode UTF-8 string.")
                        }
                    case .failure(let error):
                        print("Error: \(error)")
                    }
                }
            return Disposables.create()
        }
    }
}
