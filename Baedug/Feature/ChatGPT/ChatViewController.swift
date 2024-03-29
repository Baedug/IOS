//
//  ChatViewController.swift
//  Baedug
//
//  Created by 정성윤 on 2024/03/04.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import SnapKit

class ChatViewController : UIViewController {
    private let disposeBag = DisposeBag()
    private let chatViewModel = ChatViewModel()
    //검색 타이틀
    let search : ChatModel
    init(search : ChatModel) {
        self.search = search
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //제목
    private var searchTitle : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        label.backgroundColor = .customGray
        label.clipsToBounds = true
        return label
    }()
    //설명라벨
    private let deslabel : UILabel = {
        let label = UILabel()
        label.text = "설명"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .gray
        label.textAlignment = .left
        label.backgroundColor = .customGray
        label.clipsToBounds = true
        return label
    }()
    //설명
    private let descriptionText : UITextView = {
        let view = UITextView()
        view.backgroundColor = .customGray
        view.textColor = .white
        view.textAlignment = .left
        view.isEditable = false
        view.font = UIFont.boldSystemFont(ofSize: 18)
        view.clipsToBounds = true
        return view
    }()
    //로딩인디케이터
    private let loadingIndicator : UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        view.color = .white
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .customGray
        self.searchTitle.text = self.search.searchTitle
        setLayout()
        setBinding()
    }
}
//MARK: - setLayout
extension ChatViewController {
    private func setLayout() {
        self.view.clipsToBounds = true
        self.view.addSubview(searchTitle)
        self.view.addSubview(deslabel)
        self.view.addSubview(descriptionText)
        self.view.addSubview(loadingIndicator)
        
        searchTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(self.view.frame.height / 10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(30)
        }
        deslabel.snp.makeConstraints { make in
            make.top.equalTo(searchTitle.snp.bottom).offset(50)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(20)
        }
        loadingIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(0)
            make.height.equalTo(30)
        }
        descriptionText.snp.makeConstraints { make in
            make.top.equalTo(deslabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-self.view.frame.height / 10)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        self.loadingIndicator.startAnimating()
    }
}
//MARK: - setBinding
extension ChatViewController {
    private func setBinding() {
        chatViewModel.inputTrigger.onNext(ChatModel(searchTitle: searchTitle.text!))
        chatViewModel.outputResult
            .subscribe { result in
                self.descriptionText.text = result.element?.choices.first?.message.content
                self.loadingIndicator.stopAnimating()
            }
            .disposed(by: disposeBag)
    }
}
