//
//  CoordinatorFactory.swift
//  SearchItunes
//
//  Created by USER on 04.10.2023.
//

import UIKit

protocol CoordinatorBuilderProtocol{
    func createItunnesSearchCoordinator(navigationController: UINavigationController?, viewFactoryBuilder: BuilderProtocol) -> Coordinator
    func createAppCoordinator(navigationController: UINavigationController) -> Coordinator
}

class CoordinatorFactory: CoordinatorBuilderProtocol {
    func createItunnesSearchCoordinator(navigationController: UINavigationController?, viewFactoryBuilder: BuilderProtocol) -> Coordinator {
        ItunesSearchCoordinator(navigationController: navigationController, viewFactoryBuilder: viewFactoryBuilder)
    }
    
    func createAppCoordinator(navigationController: UINavigationController) -> Coordinator {
        AppCoordinator(navigationController: navigationController)
    }
}
