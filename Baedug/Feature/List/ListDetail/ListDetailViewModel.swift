//
//  ListDetailViewModel.swift
//  Baedug
//
//  Created by 정성윤 on 2024/03/04.
//

import Foundation
import RxSwift
import RxCocoa

class ListDetailViewModel {
    private let disposeBag = DisposeBag()
    private var getDetailNetwork : GetDetailNetwork
    
    //노트 조회
    let noteListTrigger = PublishSubject<Int>()
    let noteListResult : PublishSubject<[GetDetailData]> = PublishSubject()
    init() {
        let provider = NetworkProvider(endpoint: endpointURL)
        getDetailNetwork = provider.getDetail()
        
        setBinding()
    }
    private func setBinding() {
        noteListTrigger.subscribe(onNext: {[weak self] id in
            guard let self = self else {return}
            self.getDetailNetwork.getDetailNetwork(path: "\(getDetailURL)\(id)/note")
                .subscribe(onNext: {[weak self] result in
                    guard let self = self else { return }
                    if let data = result.body?.data {
                        noteListResult.onNext(data)
                    }
                })
                .disposed(by: self.disposeBag)
        }).disposed(by: self.disposeBag)
    }
}
