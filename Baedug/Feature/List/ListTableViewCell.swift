//
//  ListTableViewCell.swift
//  Baedug
//
//  Created by 정성윤 on 2024/03/04.
//

import Foundation
import RxSwift
import RxCocoa
import SnapKit
import UIKit

class ListTableViewCell : UITableViewCell {
    //전체 뷰
    private let totalView : UIView = {
        let view = UIView()
        view.backgroundColor = .customGray
        view.layer.cornerRadius = 10
        return view
    }()
    //제목
    private let titleLabel : UITextView = {
        let label = UITextView()
        label.isEditable = false
        label.textColor = .white
        label.backgroundColor = .customGray
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    //날짜
    private let dayLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 13)
        label.backgroundColor = .customGray
        return label
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
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    private func setupUI() {
        let contentView = self.contentView
        contentView.backgroundColor = .black
        contentView.snp.makeConstraints { make in
            make.height.equalTo(120)
            make.leading.trailing.equalToSuperview().inset(0)
        }
        totalView.addSubview(titleLabel)
        totalView.addSubview(dayLabel)
        totalView.addSubview(arrow)
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(30)
        }
        dayLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(15)
        }
        arrow.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().offset(35)
        }
        contentView.addSubview(totalView)
        totalView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(0)
            make.top.bottom.equalToSuperview().inset(10)
        }
    }
    func configure(with model: ListModel) {
        titleLabel.text = model.title
        dayLabel.text = model.day
    }
}
