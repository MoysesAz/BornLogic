//
//  SceneDelegate.swift
//  News
//
//  Created by Moyses Miranda do Vale Azevedo on 15/05/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        makeFirstScene(windowScene: windowScene)

    }

    func makeFirstScene(windowScene: UIWindowScene) {
        let window = UIWindow(windowScene: windowScene)
        let controller: HomeController = HomeController()
        let navMainView = UINavigationController(rootViewController: controller)
        window.rootViewController = navMainView
        window.makeKeyAndVisible()
        self.window = window
    }
}
