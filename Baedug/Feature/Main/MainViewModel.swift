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
    let InputTrigger = PublishRelay<Void>()
    let MainTable : BehaviorRelay<[MainModel]> = BehaviorRelay(value: [])
    
    init() {
        setBinding()
    }
    private func setBinding() {
        InputTrigger.subscribe { _ in
            let mockData = [
                MainModel(title: "인공지능", description: "인공지능에 대한 필기 입니다" ,day: "2024-02-29"),
                MainModel(title: "인공지능", description: "인공지능에 대한 필기 입니다" , day: "2024-03-01"),
                MainModel(title: "인공지능", description: "인공지능에 대한 필기 입니다" , day: "2024-03-02"),
                MainModel(title: "인공지능", description: "인공지능에 대한 필기 입니다" ,day: "2024-03-03")
            ]
            self.MainTable.accept(mockData)
        }
        .disposed(by: disposeBag)
    }
}
