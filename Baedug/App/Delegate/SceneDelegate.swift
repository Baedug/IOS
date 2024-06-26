//
//  SceneDelegate.swift
//  Baedug
//
//  Created by 정성윤 on 2024/03/03.
//

import UIKit
import SwiftKeychainWrapper
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        guard let windowScene = (scene as? UIWindowScene) else {return}
        window = UIWindow(frame: UIScreen.main.bounds)
        if let _ = KeychainWrapper.standard.string(forKey: "JWTaccessToken") {
            let viewController = LoginViewController()
            let navigationController = UINavigationController(rootViewController: viewController)
            window?.rootViewController = navigationController
        }else{
            let viewController = LoginViewController()
            let navigationController = UINavigationController(rootViewController: viewController)
            window?.rootViewController = navigationController
        }
        window?.makeKeyAndVisible() //화면에 보이게끔
        window?.windowScene = windowScene
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }

    func sceneWillResignActive(_ scene: UIScene) {
        
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }
}

