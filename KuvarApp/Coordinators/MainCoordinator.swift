//
//  MainCoordinator.swift
//  KuvarApp
//
//  Created by Ana Asceric on 23.4.24..
//

import UIKit
class MainCoordinator: BaseCoordinator, MainCoordinatorProtocol, MainViewControllerDelegate {
    
    private let window: UIWindow
   // private let mainNavigationController = UINavigationController()
    
   // private weak var navigationController: UINavigationController?

    init(window: UIWindow) {
        self.window = window
        super.init(navigationController: UINavigationController())
    }

       // Implement the method to present recipe details
       func presentRecipeDetails(for recipe: Recipe) {
           let recipeDetailsVC = RecipeDetailsViewController()
           recipeDetailsVC.recipe = recipe
           navigationController.present(recipeDetailsVC, animated: true, completion: nil)
       }

    func didSelectRecipe(_ recipe: Recipe) {
         // Call the method to present RecipeDetailsViewController
         presentRecipeDetails(for: recipe)
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
        mainViewController.delegate = self
     //  navigationController.setViewControllers([mainViewController], animated: false)
    //  window.rootViewController = navigationController
      let mainNavigationController = UINavigationController(rootViewController: mainViewController)
       window.rootViewController = mainNavigationController
        
        
        
    }
}
