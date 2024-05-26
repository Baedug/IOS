//
//  LoginViewModel.swift
//  Baedug
//
//  Created by 정성윤 on 2024/03/03.
//

import Foundation
import RxSwift
import RxCocoa
import SwiftKeychainWrapper
class LoginViewModel {
    private let disposeBag = DisposeBag()
    let inputTrigger = PublishSubject<LoginModel>()
    let outputResult : PublishSubject<LoginServiceModel> = PublishSubject()
    let loginSuccess = PublishSubject<Bool>()
    init() {
        inputTrigger.flatMapLatest { model in
            return AppleLoginService.requestLogin(request: model)
        }
        .bind(to: outputResult)
        .disposed(by: disposeBag)
        outputResult.subscribe(onNext: { result in
            guard let resultString = result.result else { return }
            let components = resultString.components(separatedBy: "accessToken: ")
            let accessToken = components.count > 1 ? components[1] : nil
            
            if let accessToken = accessToken {
                let JWTaccessToken = "Bearer \(accessToken)"
                // Save to Token
                KeychainWrapper.standard.set(JWTaccessToken, forKey: "JWTaccessToken")
                self.loginSuccess.onNext(true)
            }else{
                self.loginSuccess.onNext(false)
            }
        })
        .disposed(by: disposeBag)
    }
}
