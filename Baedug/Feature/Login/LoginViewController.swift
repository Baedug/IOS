//
//  LoginViewController.swift
//  Baedug
//
//  Created by 정성윤 on 2024/03/03.
//

import Foundation
import RxSwift
import RxCocoa
import SnapKit
import Alamofire
import UIKit
import AuthenticationServices
class LoginViewController : UIViewController{
    private let disposeBag = DisposeBag()
    private let loginViewModel = LoginViewModel()
    //이미지
    private let LogoShadow : UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "LogoShadow")
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .black
        view.clipsToBounds = true
        return view
    }()
    //애플로그인 버튼
    private let appleBtn : ASAuthorizationAppleIDButton = {
        let btn = ASAuthorizationAppleIDButton(type: .signIn, style: .white)
        btn.cornerRadius = 10
        
        return btn
    }()
    private let loadingIndicator : UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.color = .white
        view.style = .large
        view.clipsToBounds = true
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        setLayout()
        setBinding()
    }
}
//MARK: - Layout
extension LoginViewController {
    func setLayout() {
        self.view.addSubview(LogoShadow)
        self.view.addSubview(appleBtn)
        self.view.addSubview(loadingIndicator)
        LogoShadow.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview().inset(0)
        }
        appleBtn.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-100)
        }
        loadingIndicator.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(0)
            make.height.equalTo(30)
            make.center.equalToSuperview()
        }
    }
}
//MARK: - Binding
extension LoginViewController {
    private func setBinding() {
        appleBtn.rx.controlEvent(.touchUpInside)
            .subscribe(onNext: { [weak self] in
                self?.loadingIndicator.startAnimating()
                self?.handleAppleSignInButtonPress()
            })
            .disposed(by: disposeBag)
        loginViewModel.loginSuccess.bind(onNext: {[weak self] result in
            guard let self = self else { return }
            if result == true{
                self.navigationController?.pushViewController(TabBarViewController(), animated: true)
            }
        }).disposed(by: disposeBag)
    }
}
//MARK: - AppleLogin
extension LoginViewController : ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    private func handleAppleSignInButtonPress() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window ?? ASPresentationAnchor()
    }
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            
            if let accessCodeData = appleIDCredential.authorizationCode,
                let idToken = appleIDCredential.identityToken {
                let accessCode = String(data: accessCodeData, encoding: .utf8)
                let identity = String(data: idToken, encoding: .utf8)
                if let accessCodeString = accessCode,
                    let idToken = identity{
                    loginViewModel.inputTrigger.onNext(LoginModel(authCode: accessCodeString, idToken: idToken))
                    self.loadingIndicator.stopAnimating()
                }
            }else{}
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Apple Sign In Error: \(error.localizedDescription)")
    }
}
