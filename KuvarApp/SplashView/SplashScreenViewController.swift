//
//  SplashScreenViewController.swift
//  KuvarApp
//
//  Created by Ana Asceric on 23.4.24..
//



import UIKit

class SplashScreenViewController: UIViewController {
    
    
    @IBOutlet weak var splashImage: UIImageView!
    
    @IBOutlet weak var proImage: UIImageView!
    
    
    @IBOutlet weak var logoImage: UIImageView!
    
    
    @IBOutlet weak var loadingImage: UIImageView!
    
    var coordinator: MainCoordinator?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Simulate fetching data from server with a delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // Navigate to the main screen after the delay
            let mainViewController = MainViewController()
            
        }
        
        
    }
}
