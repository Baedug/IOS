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
    private var postDirectoryNetwork : PostDirectoryNetwork
    private var getDirectoryNetwork : GetDirectoryNetwork
    
    //카테고리 불러오기(디렉토리 전체 조회)
    let InputTrigger = PublishSubject<Void>()
    let ListTable : PublishSubject<[GetDirectoryData]> = PublishSubject()
    
    //Direcotry 만들기
    let DirectoryTrigger = PublishSubject<String>()
    let DirectoryResult : PublishSubject<PostDirectoryResponseModel> = PublishSubject()
    
    init() {
        let provider = NetworkProvider(endpoint: endpointURL)
        postDirectoryNetwork = provider.postDirectory()
        getDirectoryNetwork = provider.getDirectory()
        
        setBinding()
    }
    private func setBinding() {
        //디렉토리 전체 조회
        InputTrigger.subscribe { _ in
            self.getDirectoryNetwork.getDirectoryNetwork(path: getDirectoryURL)
                .subscribe { result in
                    if let data = result.element?.body?.data {
                        self.ListTable.onNext(data)
                    }
                }.disposed(by: self.disposeBag)
        }
        .disposed(by: disposeBag)
        
        //디렉토리 생성
        DirectoryTrigger.flatMapLatest { name in
            let params : [String:Any] = [
                "name" : name
            ]
            return self.postDirectoryNetwork.postDirectory(path: postDirectoryURL, params: params)
        }
        .bind(to: DirectoryResult)
        .disposed(by: disposeBag)
    }
}
