//
//  MainDetailViewController.swift
//  Baedug
//
//  Created by 정성윤 on 2024/03/04.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import SnapKit

class MainDetailViewController : UIViewController {
    private let disposeBag = DisposeBag()
    let notes : MainData
    init(notes : MainData) {
        self.notes = notes
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //필기 뷰
    private let textView : UIView = {
        let view = UIView()
        view.backgroundColor = .customYellow
        view.layer.cornerRadius = 10
        return view
    }()
    //필기 텍스트
    private let text : UITextView = {
        let text = UITextView()
        text.isEditable = false
        text.textColor = .black
        text.font = UIFont.boldSystemFont(ofSize: 18)
        text.textAlignment = .left
        text.backgroundColor = .customYellow
        return text
    }()
    //필기 날짜
    private let day : UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .right
        label.backgroundColor = .customYellow
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        self.navigationController?.navigationBar.isHidden = false
        self.title = self.notes.title
        setLayout()
        setBinding()
    }
}
//MARK: - setLayout
extension MainDetailViewController {
    private func setLayout() {
        textView.addSubview(text)
        textView.addSubview(day)
        text.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().offset(-40)
        }
        day.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-10)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(20)
        }
        self.view.addSubview(textView)
        textView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().offset(self.view.frame.height / 8)
            make.height.equalToSuperview().dividedBy(3)
        }
    }
}
//MARK: - setBinding
extension MainDetailViewController {
    private func setBinding() {
        self.text.text = "\(self.notes.title ?? "")\n\n\(self.notes.content ?? "")"
    }
}
