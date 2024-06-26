//
//  ViewController.swift
//  KuvarApp
//
//  Created by Ana Asceric on 22.4.24..
//

import UIKit

class MainViewController: UIViewController {
    
    var recipeViewController = RecipeViewController()
    var exploreViewController = ExploreRecipesViewController()
    var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarController()
        
        //    coordinator = MainCoordinator(window: self.view.window!)
        //  coordinator?.start()
    }
    
    
    func setupTabBarController() {
        
        
        let tabBarController = UITabBarController()
        //   let exploreViewController = UIViewController()
        exploreViewController.coordinator = coordinator
        exploreViewController.view.backgroundColor = .white
        //        let exploreRecipesView = ExploreRecipesViewController()
        //    exploreRecipesView.coordinator = self.coordinator
        
        exploreViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Active.png"), selectedImage: UIImage(named: "Active.png"))
        
        
        let recipeViewController = RecipeViewController()
        recipeViewController.coordinator = coordinator
        recipeViewController.view.backgroundColor = .white
        recipeViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Recipes.png"),selectedImage: UIImage(named: "Recipes.png"))
        
        let favoritesViewController = FavoritesViewController()
        favoritesViewController.coordinator = coordinator
        favoritesViewController.view.backgroundColor = .white
        favoritesViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Favorites.png"), selectedImage: UIImage(named: "Favorites.png"))
        
        tabBarController.tabBar.tintColor = .red
        tabBarController.viewControllers = [exploreViewController, recipeViewController, favoritesViewController]
        
        
        addChild(tabBarController)
        tabBarController.view.frame = view.bounds
        view.addSubview(tabBarController.view)
        tabBarController.didMove(toParent: self)
        
        recipeViewController.didMove(toParent: tabBarController)
        
    }
}





