//
//  TabBarViewController.swift
//  Baedug
//
//  Created by 정성윤 on 2024/03/04.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import SnapKit

class TabBarViewController : UITabBarController {
    private let disposeBag = DisposeBag()
    private let tabBarViewModel = TabBarViewModel()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.backgroundColor = .customGray
        self.tabBar.tintColor = .white
        self.tabBar.unselectedItemTintColor = .lightGray
        self.tabBar.layer.shadowOffset = CGSize(width: 0, height: -5)
        self.tabBar.layer.shadowColor = UIColor.customGray.cgColor
        self.tabBar.layer.shadowOpacity = 5
        self.title = ""
        setupView()
        setBinding()
    }
}
//MARK: - setup
extension TabBarViewController {
    private func setupView() {
        let firstVC = MainViewController()
        let firstTabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "list.bullet"), tag: 0)
        firstVC.tabBarItem = firstTabBarItem
        
        let secondVC = ListViewController()
        let secondTabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "plus.circle"), tag: 1)
        secondVC.tabBarItem = secondTabBarItem
        
        let thirdVC = PersonViewController()
        let thirdTabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person.fill"), tag: 2)
        thirdVC.tabBarItem = thirdTabBarItem
        
        self.viewControllers = [firstVC, secondVC, thirdVC]
    }
}
//MARK: - setBinding
extension TabBarViewController {
    private func setBinding() {
        self.rx.didSelect
            .subscribe(onNext: { [weak self] viewController in
                if let index = self?.viewControllers?.firstIndex(of: viewController) {
                    self?.tabBarViewModel.selectedTabIndex.onNext(index)
                }
            })
            .disposed(by: disposeBag)
        tabBarViewModel.selectedTabTitle
            .drive(onNext: { title in
                print("Selected tab title : \(title)")
            })
            .disposed(by: disposeBag)
    }
}
