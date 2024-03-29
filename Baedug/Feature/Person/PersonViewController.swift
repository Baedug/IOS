//
//  PersonViewController.swift
//  Baedug
//
//  Created by 정성윤 on 2024/03/04.
//

import Foundation
import RxSwift
import RxCocoa
import SnapKit
import UIKit
class PersonViewController : UIViewController {
    private let disposeBag = DisposeBag()
    //이름
    private let nameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = .white
        label.text = "성윤"
        label.textAlignment = .left
        return label
    }()
    //이메일
    private let emailLabel : UILabel = {
        let label = UILabel()
        label.text = "jeoungsung12@naver.com"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    //계정 설정뷰
    private let accountView : UIStackView = {
        let view = UIStackView()
        view.backgroundColor = .black
        view.spacing = 50
        view.axis = .vertical
        view.distribution = .fill
        return view
    }()
    //지원뷰
    private let supportView : UIStackView = {
        let view = UIStackView()
        view.backgroundColor = .black
        view.spacing = 30
        view.axis = .vertical
        view.distribution = .fill
        return view
    }()
    //화살표
    private var arrow : UILabel = {
        let label = UILabel()
        label.backgroundColor = .customGray
        label.text = ">"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        setLayout()
        setBinding()
    }
}
//MARK: - setLayout
extension PersonViewController {
    private func setLayout() {
        self.view.addSubview(nameLabel)
        self.view.addSubview(emailLabel)
        AddaccountView()
        self.view.addSubview(accountView)
        AddsupportView()
        self.view.addSubview(supportView)
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(self.view.frame.height / 8.5)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(30)
        }
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(20)
        }
        accountView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.center.equalToSuperview()
            make.height.equalTo(200)
        }
        supportView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.equalTo(accountView.snp.bottom).offset(50)
            make.height.equalTo(100)
        }
    }
    private func AddaccountView() {
        //계정 설정
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = .gray
        label.textAlignment = .left
        label.text = "계정 설정"
        accountView.addArrangedSubview(label)
        label.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(0)
            make.height.equalTo(20)
        }
        let accountList = ["내 필기\t\t\t\t\t\t\t\t\t>", "중요 필기\t\t\t\t\t\t\t\t\t>", "로그아웃\t\t\t\t\t\t\t\t\t>"]
        accountList.forEach { list in
            let btn = UIButton()
            btn.setTitleColor(.white, for: .normal)
            btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            btn.setTitle(list, for: .normal)
            accountView.addArrangedSubview(btn)
            btn.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(0)
            }
        }
    }
    private func AddsupportView() {
        //계정 설정
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = .gray
        label.textAlignment = .left
        label.text = "지원"
        supportView.addArrangedSubview(label)
        label.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(0)
            make.height.equalTo(20)
        }
        let btn = UIButton()
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        btn.setTitle("피드백 보내기\t\t\t\t\t\t\t\t>", for: .normal)
        supportView.addArrangedSubview(btn)
    }
}
//MARK: - setBinding
extension PersonViewController {
    private func setBinding() {
        for case let button as UIButton in supportView.subviews {
            button.rx.tap
                .subscribe { _ in
                    if let url = URL(string: "https://forms.gle/NAihnLoefXM2fEj79"){
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }else{}
                }
                .disposed(by: disposeBag)
        }
    }
}
