//
//  CoordinatorFactory.swift
//  SearchItunes
//
//  Created by USER on 04.10.2023.
//

import UIKit

protocol CoordinatorBuilderProtocol{
    func createItunnesSearchCoordinator(navigationController: UINavigationController?, viewBuilder: BuilderProtocol) -> Coordinator
    func createAppCoordinator(navigationController: UINavigationController) -> Coordinator
}

final class CoordinatorFactory: CoordinatorBuilderProtocol {
    func createItunnesSearchCoordinator(navigationController: UINavigationController?, viewBuilder: BuilderProtocol) -> Coordinator {
        ItunesSearchCoordinator(navigationController: navigationController, viewBuilder: viewBuilder)
    }
    
    func createAppCoordinator(navigationController: UINavigationController) -> Coordinator {
        AppCoordinator(navigationController: navigationController)
    }
}
