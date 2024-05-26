//
//  MainViewModel.swift
//  Baedug
//
//  Created by 정성윤 on 2024/03/03.
//

import Foundation
import RxSwift
import RxCocoa

class MainViewModel {
    private let disposeBag = DisposeBag()
    private var getHeartNetwork : GetHeartNetwork
    
    //좋아요 리스트 조회
    let InputTrigger = PublishSubject<Void>()
    let MainTable : PublishSubject<[MainData]> = PublishSubject()
    
    init() {
        let provider = NetworkProvider(endpoint: endpointURL)
        getHeartNetwork = provider.getHeart()
        
        setBinding()
    }
    private func setBinding() {
        InputTrigger.subscribe { _ in
            self.getHeartNetwork.getHeartNetwork(path: getHeartURL)
                .subscribe { result in
                    if let data = result.body?.data {
                        self.MainTable.onNext(data)
                    }
                }.disposed(by: self.disposeBag)
        }
        .disposed(by: disposeBag)
        
    }
}
