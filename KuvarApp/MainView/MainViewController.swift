//
//  ViewController.swift
//  KuvarApp
//
//  Created by Ana Asceric on 22.4.24..
//

import UIKit

class MainViewController: UIViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarController()
    }


  
        
    func setupTabBarController() {
           
           let tabBarController = UITabBarController()
           
         
           let firstViewController = UIViewController()
           firstViewController.view.backgroundColor = .red
           firstViewController.tabBarItem = UITabBarItem(title: "First", image: nil, selectedImage: nil)
           
           let secondViewController = UIViewController()
           secondViewController.view.backgroundColor = .white
           secondViewController.tabBarItem = UITabBarItem(title: "Second", image: nil, selectedImage: nil)
           
           let thirdViewController = UIViewController()
           thirdViewController.view.backgroundColor = .yellow
           thirdViewController.tabBarItem = UITabBarItem(title: "Third", image: nil, selectedImage: nil)
           
        
           tabBarController.viewControllers = [firstViewController, secondViewController, thirdViewController]
           
           
           addChild(tabBarController)
           tabBarController.view.frame = view.bounds
           view.addSubview(tabBarController.view)
           tabBarController.didMove(toParent: self)
       }
    }

  



