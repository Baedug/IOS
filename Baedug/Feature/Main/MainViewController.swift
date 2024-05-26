//
//  ViewController.swift
//  Baedug
//
//  Created by 정성윤 on 2024/03/03.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class MainViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let mainViewModel = MainViewModel()
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
    //중요필기 라벨
    private let importLabel : UILabel = {
        let label = UILabel()
        label.text = "중요 필기"
        label.textColor = .lightGray
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    //테이블뷰(4개)
    private let tableView : UITableView = {
        let view = UITableView()
        view.backgroundColor = .black
        view.separatorStyle = .none
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.clipsToBounds = true
        view.register(MainTableViewCell.self, forCellReuseIdentifier: "Cell")
        return view
    }()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.tabBarController?.tabBar.isHidden = false
        mainViewModel.InputTrigger.onNext(())
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        setLayout()
        setBinding()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItem.hidesBackButton = false
//        self.tabBarController?.tabBar.isHidden = true
    }
}
//MARK: - setLayout
extension MainViewController {
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
        self.view.addSubview(importLabel)
        self.view.addSubview(tableView)
        searchView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
        importLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.leading.equalToSuperview().offset(30)
            make.top.equalTo(searchView.snp.bottom).offset(20)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(importLabel.snp.bottom).offset(20)
            make.bottom.equalToSuperview().offset(0)
            make.leading.trailing.equalToSuperview().inset(30)
        }
    }
}
//MARK: - setBinding
extension MainViewController {
    private func setBinding() {
        mainViewModel.InputTrigger.onNext(())
        mainViewModel.MainTable.bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: MainTableViewCell.self)) { index, model, cell in
            cell.configure(with: model)
            cell.selectionStyle = .none
        }
        .disposed(by: disposeBag)
        tableView.rx.modelSelected(MainData.self)
            .subscribe { selectedModel in
                self.navigationController?.pushViewController(MainDetailViewController(notes: selectedModel), animated: true)
            }
            .disposed(by: disposeBag)
        searchBtn.rx.tap
            .subscribe { _ in
                self.present(ChatViewController(search: ChatModel(searchTitle: self.searchText.text!)), animated: true)
            }
            .disposed(by: disposeBag)
    }
}
