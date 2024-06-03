//
//  AppDelegate.swift
//  KuvarApp
//
//  Created by Ana Asceric on 22.4.24..
//
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
 
        let favoritesViewController = FavoritesViewController()
            let recipeViewController = RecipeViewController()
           let exploreViewController = ExploreRecipesViewController()
        
            // Embed each view controller in a navigation controller...
           let favoritesNavigationController = UINavigationController(rootViewController: favoritesViewController)
            let recipeNavigationController = UINavigationController(rootViewController: recipeViewController)
            let exploreNavigationController = UINavigationController(rootViewController: exploreViewController)
            // Set up a tab bar controller...
            let tabBarController = UITabBarController()
            tabBarController.viewControllers = [favoritesNavigationController, recipeNavigationController, exploreNavigationController]
            
            // Make the tab bar controller the root view controller.
           window?.rootViewController = tabBarController
            window?.makeKeyAndVisible()
            
            return true
        
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
    
    
    
}

