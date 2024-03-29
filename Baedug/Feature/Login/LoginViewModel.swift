//
//  LoginViewModel.swift
//  Baedug
//
//  Created by 정성윤 on 2024/03/03.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel {
    private let disposeBag = DisposeBag()
    let inputTrigger = PublishSubject<LoginModel>()
    let outputResult : PublishSubject<Void> = PublishSubject()
    
    init() {
        inputTrigger.flatMapLatest { model in
            return AppleLoginService.requestLogin(request: model)
        }
        .bind(to: outputResult)
        .disposed(by: disposeBag)
    }
}
