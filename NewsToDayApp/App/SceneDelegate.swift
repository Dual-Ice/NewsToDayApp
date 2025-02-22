//
//  SceneDelegate.swift
//  NewsToDayApp
//
//  Created by Sergey on 17.03.2024.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        UserDefaults.standard.addObserver(self, forKeyPath: "theme", options: [.new], context: nil)
       let theme = UserDefaults.standard.object(forKey: "theme") as? String
        if theme == "dark" {
            window?.overrideUserInterfaceStyle = Theme.dark.uiInterfaceStyle
        }
        
        window?.makeKeyAndVisible()
//        let navigationVC = UINavigationController()
//        let mainVC = MainBuilder(navigationVC: navigationVC).buildMainView()
//        navigationVC.setViewControllers([mainVC], animated: true)
//        let navigationVC = CustomTabBarController()
//        window?.rootViewController = navigationVC

        if  UserDefaults.standard.bool(forKey: "isOnboardingCompleted"){
            checkAuthentication()
        } else {
            let vc = OnbordingBuilder().buildOnbordingVC()
            vc.modalPresentationStyle = .fullScreen
            self.window?.rootViewController = vc
            UserDefaults.standard.addObserver(self, forKeyPath: "theme", options: [.new], context: nil)
        }
    }
    
    func checkAuthentication() {
        if Auth.auth().currentUser == nil {
            let navigationController = UINavigationController()
            let vc = AuthBuilder().buildLoginView(
                navigationController: navigationController
            )
            navigationController.setViewControllers([vc], animated: true)
            window?.rootViewController = navigationController
            UserDefaults.standard.addObserver(self, forKeyPath: "theme", options: [.new], context: nil)
            
        } else {
            AuthManager.shared.fetchUser { [weak self] user, error in
                guard let user = user else { return }
                UserManager.shared.syncUser(userObject: user)
                let tabBarController = CustomTabBarController()
                self?.window?.rootViewController = tabBarController
                UserDefaults.standard.addObserver(self!, forKeyPath: "theme", options: [.new], context: nil)
            }
        }
    }
    
    deinit {
        
        UserDefaults.standard.removeObserver(self, forKeyPath: "theme", context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        guard  let change = change,
            object != nil,
            let themeValue = change[.newKey] as? String,
            let theme = Theme(rawValue: themeValue)?.uiInterfaceStyle
        else { return }

        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveLinear, animations: { [weak self] in
            self?.window?.overrideUserInterfaceStyle = theme
        }, completion: .none)
    }
    

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

