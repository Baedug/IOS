//
//  ChatViewModel.swift
//  Baedug
//
//  Created by 정성윤 on 2024/03/04.
//

import Foundation
import RxSwift
import RxCocoa
import SnapKit

class ChatViewModel {
    private let disposeBag = DisposeBag()
    let inputTrigger = PublishSubject<ChatModel>()
    let outputResult = PublishSubject<ChatServiceModel>()
    
    init() {
        inputTrigger.flatMapLatest { chat in
            return ChatGPTService.requestChat(searchTitle: chat)
        }
        .bind(to: outputResult)
        .disposed(by: disposeBag)
    }
}
