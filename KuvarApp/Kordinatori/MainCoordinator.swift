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
        window.rootViewController = splashViewController
        window.makeKeyAndVisible()

        // Delay for 2 seconds before navigating to the main screen
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.showMainScreen()
            
          
        }
        
      //  self.showFirstViewController()
    }
// MARK: - private method
    private func showMainScreen() {
        let mainViewController = MainViewController()
        mainViewController.coordinator = self
        navigationController.setViewControllers([mainViewController], animated: false)
        window.rootViewController = navigationController
    }
    
 //   private func showFirstViewController() {
   //     let firstViewController = MainViewController()
     //   firstViewController.coordinator = self
       // navigationController.pushViewController(firstViewController, animated: true)
    //}
    
    // Implement other navigation methods as needed
}

