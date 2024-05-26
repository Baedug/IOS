//
//  ListDetailViewController.swift
//  Baedug
//
//  Created by 정성윤 on 2024/03/04.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import SnapKit

class ListDetailViewController : UIViewController {
    private let disposeBag = DisposeBag()
    private let listDetailViewModel = ListDetailViewModel()
    let directoryData : GetDirectoryData
    init(directoryData : GetDirectoryData) {
        self.directoryData = directoryData
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //필기 생성
    private lazy var addBtn : UIBarButtonItem = {
        let btn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
        btn.tintColor = .white
        return btn
    }()
    //필기 라벨
    private let cateLabel : UILabel = {
        let label = UILabel()
        label.text = "\t필기"
        label.textColor = .gray
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    //테이블
    private let tableView : UITableView = {
        let view = UITableView()
        view.backgroundColor = .black
        view.separatorStyle = .none
        view.clipsToBounds = true
        view.register(ListDetailTableViewCell.self, forCellReuseIdentifier: "Cell")
        return view
    }()
    //로딩인디케이터
    private let loadingIndicator : UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        view.color = .white
        return view
    }()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listDetailViewModel.noteListTrigger.onNext((directoryData.id ?? 0))
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.isHidden = false
        self.view.backgroundColor = .black
        self.title = directoryData.name
        self.navigationItem.rightBarButtonItem = addBtn
        setLayout()
        setBinding()
    }
}
//MARK: - setLayout
extension ListDetailViewController {
    private func setLayout() {
        self.view.addSubview(cateLabel)
        self.view.addSubview(tableView)
        self.view.addSubview(loadingIndicator)
        cateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(30)
        }
        loadingIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(30)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(cateLabel.snp.bottom).offset(20)
            make.bottom.equalToSuperview().offset(0)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        self.loadingIndicator.startAnimating()
    }
}
//MARK: - setBinding
extension ListDetailViewController {
    private func setBinding() {
        listDetailViewModel.noteListTrigger.onNext(directoryData.id ?? 0)
        listDetailViewModel.noteListResult.bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: ListDetailTableViewCell.self)) { index, model, cell in
            self.loadingIndicator.stopAnimating()
            cell.configure(with: model)
            cell.selectionStyle = .none
        }.disposed(by: disposeBag)
        tableView.rx.modelSelected(GetDetailData.self)
            .subscribe { selectedModel in
                self.navigationController?.pushViewController(DetailSelectViewController(notes: selectedModel), animated: true)
            }
            .disposed(by: disposeBag)
        addBtn.rx.tap
            .bind { _ in
                self.navigationController?.pushViewController(AddViewController(id: "\(self.directoryData.id ?? 0)"), animated: true)
            }.disposed(by: disposeBag)
    }
}
