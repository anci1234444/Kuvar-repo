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
    
    var didFinishSplashScreen: (() -> Void)?
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        print("Splash screen delay completed.")
        self.didFinishSplashScreen?()
        }
        
        
    }
}
