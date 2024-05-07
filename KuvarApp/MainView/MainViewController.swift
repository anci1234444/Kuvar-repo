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
        recipeViewController.view.backgroundColor = .red
        recipeViewController.tabBarItem = UITabBarItem(title: "First", image: nil, selectedImage: nil)
        
        let secondViewController = UIViewController()
        secondViewController.view.backgroundColor = .white
        secondViewController.tabBarItem = UITabBarItem(title: "Second", image: nil, selectedImage: nil)
        
        let thirdViewController = UIViewController()
        thirdViewController.view.backgroundColor = .yellow
        thirdViewController.tabBarItem = UITabBarItem(title: "Third", image: nil, selectedImage: nil)
        
        
        tabBarController.viewControllers = [recipeViewController, secondViewController, thirdViewController]
        
        
        addChild(tabBarController)
        tabBarController.view.frame = view.bounds
        view.addSubview(tabBarController.view)
        tabBarController.didMove(toParent: self)
        
        recipeViewController.didMove(toParent: tabBarController)
    }
}





