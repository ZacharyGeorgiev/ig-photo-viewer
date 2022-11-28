//
//  AppCoordinator.swift
//  TFPresentation
//
//  Created by Zahari Georgiev on 24/11/2022.
//

import UIKit

public final class AppCoordinator: Coordinator {
        
    private var navigationController: UINavigationController?
    private var childCoordinator: Coordinator?
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    public func start() {
        let launchVC = LaunchViewController(with: self)
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.setViewControllers([launchVC], animated: false)
    }
}

// MARK: LaunchRoutable
extension AppCoordinator: LaunchRouter {
    
}
