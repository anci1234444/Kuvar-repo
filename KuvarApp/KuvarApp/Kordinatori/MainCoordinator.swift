//
//  MainCoordinator.swift
//  KuvarApp
//
//  Created by Ana Asceric on 23.4.24..
//
class MainCoordinator: BaseCoordinator {
    
    override func start() {
        showFirstViewController()
    }
    
    private func showFirstViewController() {
        let firstViewController = ViewController()
        firstViewController.coordinator = self
        navigationController.pushViewController(firstViewController, animated: true)
    }
    
    // Implement other navigation methods as needed
}
