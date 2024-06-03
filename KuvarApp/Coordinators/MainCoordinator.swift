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
    private let navigController = UINavigationController()
    
    
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
        mainViewController.coordinator = self
        //  navigationController.setViewControllers([mainViewController], animated: false)
        //  window.rootViewController = navigationController
        let mainNavigationController = UINavigationController(rootViewController: mainViewController)
        window.rootViewController = mainNavigationController
        
        
        
    }

    func showRecipeDetails(for recipe: Recipe, controller: UIViewController) {
        let recipeDetailsVC = RecipeDetailsViewController()
       recipeDetailsVC.recipe = recipe
        //present screen recipe details modally
        controller.present(recipeDetailsVC, animated: true, completion: nil)
   
  
    }

}
