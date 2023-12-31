//
//  AppCoordinator.swift
//  SearchItunes
//
//  Created by USER on 04.10.2023.
//

import UIKit

final class AppCoordinator: Coordinator {
    let navigationController: UINavigationController?
    var childCoordinator: Coordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController =  navigationController
    }
    
    func start() {
        showItunesSearchFlow()
    }
    
    private func showItunesSearchFlow(){
        let itunesSearchCoordinator = CoordinatorFactory().createItunnesSearchCoordinator(navigationController: navigationController, viewBuilder: ViewControlerBuilder())
        childCoordinator = itunesSearchCoordinator
        itunesSearchCoordinator.start()
    }
}
