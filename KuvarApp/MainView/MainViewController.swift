//
//  ViewController.swift
//  KuvarApp
//
//  Created by Ana Asceric on 22.4.24..
//

import UIKit

class MainViewController: UIViewController {
    
    var recipeViewController = RecipeViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarController()
    }
    
    
    func setupTabBarController() {
        
        
        let tabBarController = UITabBarController()
        
        let recipeViewController = RecipeViewController()
        recipeViewController.view.backgroundColor = .white

        recipeViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Active.png"), selectedImage: UIImage(named: "Active.png"))
       

        
        let secondViewController = UIViewController()
        secondViewController.view.backgroundColor = .white
        secondViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Recipes.png"), selectedImage:
        UIImage(named: "Recipes.png"))
        
        let favoritesViewController = FavoritesViewController()
        favoritesViewController.view.backgroundColor = .white
        favoritesViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Favorites.png"), selectedImage: UIImage(named: "Favorites.png"))
        
        tabBarController.tabBar.tintColor = .red
        tabBarController.viewControllers = [recipeViewController, secondViewController, favoritesViewController]
        
        
        addChild(tabBarController)
        tabBarController.view.frame = view.bounds
        view.addSubview(tabBarController.view)
        tabBarController.didMove(toParent: self)
        
        recipeViewController.didMove(toParent: tabBarController)
    }
}





