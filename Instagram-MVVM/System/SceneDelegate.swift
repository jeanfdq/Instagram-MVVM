//
//  SceneDelegate.swift
//  Instagram-MVVM
//
//  Created by Jean Paul Borges Manzini on 07/02/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        
        guard !JailbreakDetection.detect() else {
            goToBlockJailbreak()
            return
        }
        
        guard let window = window else {return}
        window.rootViewController = MainViewController()
        window.makeKeyAndVisible()
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
        
        isMaintenanceSystem()
        
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

    // MARK: - functions
    fileprivate func goToBlockJailbreak(){
        guard let window = window else {return}
        window.rootViewController = JailbreakViewController()
        window.makeKeyAndVisible()
    }
    
    fileprivate func isMaintenanceSystem(){
        guard let isMaintenance = RemoteConfigValues.RCAppOut().value(), isMaintenance else {return}
        guard let messsage = RemoteConfigValues.RCAppOutMessage().value() else {return}
        
        let maintenanceVC = MaintenanceViewController()
        maintenanceVC.maintenanceMsg.text = messsage
        
        guard let window = window else {return}
        window.rootViewController = maintenanceVC
        window.makeKeyAndVisible()
    }

}

