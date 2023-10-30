//
//  SceneDelegate.swift
//  MyJob
//
//  Created by Philipp Zeppelin on 30.10.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        let builder = ModuleBuilder()
        let viewController = UINavigationController()
        let router = Router(builder: builder, rootController: viewController)
        router.initialViewController()
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        self.window = window
    }
}
