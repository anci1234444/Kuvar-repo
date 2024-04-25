//
//  MainCoordinator.swift
//  KuvarApp
//
//  Created by Ana Asceric on 23.4.24..
//

import UIKit
class MainCoordinator: BaseCoordinator {
    
    private let window: UIWindow
    private let mainNavigationController = UINavigationController()
    
    init(window: UIWindow) {
        self.window = window
        super.init(navigationController: mainNavigationController)
    }
    
    override func start() {
        let splashViewController = SplashScreenViewController(nibName: "SplashScreenViewController", bundle: nil)
        
        splashViewController.didFinishSplashScreen = { [weak self] in
        self?.showMainScreen()
        }
        
        window.rootViewController = splashViewController
        window.makeKeyAndVisible()
    }
    
    func showMainScreen() {
        let mainViewController = MainViewController()
        navigationController.setViewControllers([mainViewController], animated: false)
        window.rootViewController = navigationController
        
       
    }
}
