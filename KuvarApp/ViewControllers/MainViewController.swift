//
//  ViewController.swift
//  KuvarApp
//
//  Created by Ana Asceric on 22.4.24..
//

import UIKit
protocol MainViewControllerDelegate: AnyObject {
    func didSelectRecipe(_ recipe: Recipe)
}
class MainViewController: UIViewController {
    weak var delegate: MainViewControllerDelegate?
    var recipeViewController = RecipeViewController()
    var exploreViewController = ExploreRecipesViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarController()
    }
    
    
    func setupTabBarController() {
        
        
        let tabBarController = UITabBarController()
     //   let exploreViewController = UIViewController()
            exploreViewController.view.backgroundColor = .white
            let exploreRecipesView = ExploreRecipesViewController()
            
            
            exploreViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Active.png"), selectedImage: UIImage(named: "Active.png"))
        
        
        let recipeViewController = RecipeViewController()
        recipeViewController.view.backgroundColor = .white
        recipeViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Recipes.png"), selectedImage:
                                                        UIImage(named: "Recipes.png"))
        
        let favoritesViewController = FavoritesViewController()
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
    
    func recipeSelected(_ recipe: Recipe) {
        let selectedRecipe = Recipe(from: Decoder as! Decoder)
               delegate?.didSelectRecipe(selectedRecipe)
        
    }
}





