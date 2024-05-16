//
//  ListViewController.swift
//  Baedug
//
//  Created by 정성윤 on 2024/03/04.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import SnapKit

class ListViewController : UIViewController {
    private let disposeBag = DisposeBag()
    private let listViewModel = ListViewModel()
    //카테고리 생성
    private let addBtn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .black
        btn.tintColor = .white
        btn.setImage(UIImage(systemName: "plus"), for: .normal)
        return btn
    }()
    //카테고리 라벨
    private let cateLabel : UILabel = {
        let label = UILabel()
        label.text = "카테고리"
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
        view.register(ListTableViewCell.self, forCellReuseIdentifier: "Cell")
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
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        setLayout()
        setBinding()
    }
}
//MARK: - setLayout
extension ListViewController {
    private func setLayout() {
        self.view.addSubview(addBtn)
        self.view.addSubview(cateLabel)
        self.view.addSubview(tableView)
        self.view.addSubview(loadingIndicator)
        addBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-20)
            make.height.width.equalTo(30)
        }
        cateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(30)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(cateLabel.snp.bottom).offset(20)
            make.bottom.equalToSuperview().offset(0)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        loadingIndicator.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(30)
            make.center.equalToSuperview()
        }
    }
}
//MARK: - setBinding
extension ListViewController {
    private func setBinding() {
        listViewModel.InputTrigger.accept(())
        listViewModel.ListTable.bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: ListTableViewCell.self)) { index, model, cell in
            cell.configure(with: model)
            cell.selectionStyle = .none
        }
        .disposed(by: disposeBag)
        tableView.rx.modelSelected(ListModel.self)
            .subscribe { selectedModel in
                self.navigationController?.pushViewController(ListDetailViewController(titleText: selectedModel), animated: true)
            }
            .disposed(by: disposeBag)
        addBtn.rx.tap
            .subscribe { _ in
                self.Alert()
            }
            .disposed(by: disposeBag)
    }
}
//MARK: - Alert
extension ListViewController {
    private func Alert() {
        let alert = UIAlertController(title: "카테고리", message: "카테고리를 추가해보세요!", preferredStyle: .alert)
        alert.addTextField{ textField in
            textField.placeholder = "입력.."
        }
        let Ok = UIAlertAction(title: "확인", style: .default){ _ in
            
        }
        let Cancle = UIAlertAction(title: "취소", style: .destructive)
        alert.addAction(Ok)
        alert.addAction(Cancle)
        self.present(alert, animated: true)
    }
}
