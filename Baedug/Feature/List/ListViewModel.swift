//
//  ListViewModel.swift
//  Baedug
//
//  Created by 정성윤 on 2024/03/04.
//
import Foundation
import RxSwift
import RxCocoa

class ListViewModel {
    private let disposeBag = DisposeBag()
    let InputTrigger = PublishRelay<Void>()
    let ListTable : BehaviorRelay<[ListModel]> = BehaviorRelay(value: [])
    
    init() {
        setBinding()
    }
    private func setBinding() {
        InputTrigger.subscribe { _ in
            let mockData = [
                ListModel(title: "인공지능", description: "인공지능에 대한 필기 입니다" ,day: "2024-02-29"),
                ListModel(title: "인공지능", description: "인공지능에 대한 필기 입니다" , day: "2024-03-01"),
                ListModel(title: "인공지능", description: "인공지능에 대한 필기 입니다" , day: "2024-03-02"),
                ListModel(title: "인공지능", description: "인공지능에 대한 필기 입니다" ,day: "2024-03-03"),
                ListModel(title: "인공지능", description: "인공지능에 대한 필기 입니다" ,day: "2024-03-03"),
                ListModel(title: "인공지능", description: "인공지능에 대한 필기 입니다" ,day: "2024-03-03"),
                ListModel(title: "인공지능", description: "인공지능에 대한 필기 입니다" ,day: "2024-03-03")
            ]
            self.ListTable.accept(mockData)
        }
        .disposed(by: disposeBag)
    }
}
