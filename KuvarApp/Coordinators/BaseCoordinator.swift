//
//  BaseCordinator.swift
//  KuvarApp
//
//  Created by Ana Asceric on 22.4.24..
//
import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    func start()
}

class BaseCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        fatalError("start() method must be implemented")
    }
}
