//
//  AddViewModel.swift
//  Baedug
//
//  Created by 정성윤 on 2024/03/04.
//

import Foundation
import RxSwift
import RxCocoa
import SnapKit
class AddViewModel {
    private let disposeBag = DisposeBag()
    private var postNoteNetwork : PostNoteNetwork
    private var postHeartNetwork : PostHeartNetwork
    
    let noteTrigger = PublishSubject<[String]>()
    let noteResult : PublishSubject<AddNoteResponseModel> = PublishSubject()
    
    let heartTrigger = PublishSubject<String>()
    let heartResult : PublishSubject<PostHeartResponseModel> = PublishSubject()
    
    init() {
        let provider = NetworkProvider(endpoint: endpointURL)
        postNoteNetwork = provider.postNote()
        postHeartNetwork = provider.postHeart()
        
        noteTrigger.flatMapLatest { params in
            let parameters : [String:Any] = [
                "title" : params[1],
                "content" : params[2]
            ]
            return self.postNoteNetwork.postNoteNetwork(path: "\(postNoteURL)\(params[0])/note", params: parameters)
        }
        .bind(to: noteResult)
        .disposed(by: disposeBag)
        
        heartTrigger.flatMapLatest { id in
            return self.postHeartNetwork.postHeartNetwork(path: "\(postHeartURL)\(id)/heart", params: [:])
        }
        .bind(to: heartResult)
        .disposed(by: disposeBag)
    }
}
