//
//  AddViewController.swift
//  Baedug
//
//  Created by 정성윤 on 2024/03/04.
//
import Foundation
import UIKit
import RxSwift
import RxCocoa
import SnapKit

class AddViewController : UIViewController, UITextViewDelegate {
    private let disposeBag = DisposeBag()
    
    //chatGPT 검색
    private let searchView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.customGray.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    //검색 텍스트
    private let searchText : UITextField = {
        let text = UITextField()
        text.textColor = .black
        text.backgroundColor = .white
        text.placeholder = "Chat에게 질문해 보세요!"
        text.font = UIFont.boldSystemFont(ofSize: 15)
        return text
    }()
    //검색버튼
    private let searchBtn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .white
        btn.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        btn.tintColor = .black
        return btn
    }()
    //필기 뷰
    private let textView : UIView = {
        let view = UIView()
        view.backgroundColor = .customYellow
        view.layer.cornerRadius = 10
        return view
    }()
    //제목
    private let titleText : UITextField = {
        let text = UITextField()
        text.placeholder = "제목"
        text.textAlignment = .left
        text.textColor = .black
        text.font = UIFont.boldSystemFont(ofSize: 20)
        text.backgroundColor = .customYellow
        return text
    }()
    //필기 텍스트
    private let text : UITextView = {
        let text = UITextView()
        text.isEditable = true
        text.textColor = .gray
        text.font = UIFont.boldSystemFont(ofSize: 15)
        text.textAlignment = .left
        text.backgroundColor = .customYellow
        text.text = "필기를 해보세요!"
        return text
    }()
    //중요표시
    private let heartBtn : UIButton = {
        let view = UIButton()
        view.backgroundColor = .customYellow
        view.setImage(UIImage(named: "heartDefault"), for: .normal)
        return view
    }()
    //필기 날짜
    private let day : UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .right
        label.backgroundColor = .customYellow
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        label.text = formatter.string(from: date)
        
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        text.delegate = self
        setLayout()
        setBinding()
    }
}
//MARK: - setLayout
extension AddViewController {
    private func setLayout() {
        searchView.addSubview(searchText)
        searchView.addSubview(searchBtn)
        searchText.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview().inset(10)
            make.width.equalToSuperview().dividedBy(1.5)
        }
        searchBtn.snp.makeConstraints { make in
            make.width.height.equalTo(30)
            make.trailing.top.bottom.equalToSuperview().inset(10)
        }
        self.view.addSubview(searchView)
        
        textView.addSubview(titleText)
        textView.addSubview(text)
        textView.addSubview(day)
        textView.addSubview(heartBtn)
        titleText.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview().inset(20)
            make.height.equalTo(20)
        }
        text.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(titleText.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-40)
        }
        day.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-10)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(20)
        }
        heartBtn.snp.makeConstraints { make in
            make.height.width.equalTo(30)
            make.leading.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-10)
        }
        self.view.addSubview(textView)
        searchView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(self.view.frame.height / 8)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        textView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(searchView.snp.bottom).offset(30)
            make.height.equalToSuperview().dividedBy(3)
        }
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor != .black {
            textView.text = ""
            textView.textColor = .black
        }
    }
}
//MARK: - setBinding
extension AddViewController {
    private func setBinding() {
        searchBtn.rx.tap
            .subscribe { _ in
                self.present(ChatViewController(search: ChatModel(searchTitle: self.searchText.text!)), animated: true)
            }
            .disposed(by: disposeBag)
        heartBtn.rx.tap
            .subscribe { _ in
                self.heartBtn.setImage(UIImage(named: "heartFill"), for: .normal)
            }
            .disposed(by: disposeBag)
    }
}
