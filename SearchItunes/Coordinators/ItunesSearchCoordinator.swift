//
//  Router.swift
//  SearchItunes
//
//  Created by USER on 04.10.2023.
//

import UIKit

//typealias CoordinatorHandler = () -> ()

protocol Coordinator: AnyObject { //для всех координаторов базовый протокол
    var navigationController: UINavigationController? {get set}
    //var flowComplitionHandler: CoordinatorHandler? // если несколько flow, для обработки завершениия flow
    func start() // начинается flow
    
}

protocol ItunesSearchCoordinatorProtocol: Coordinator {
    var viewFactoryBuilder: BuilderProtocol? {get set}
}

protocol ItunesSearchPresenterDeleegate: AnyObject{
    func didSelectSong(infoSong: Items?)
}

class ItunesSearchCoordinator: Coordinator {  // роутинг будет происходить из презентера в презентер
    var navigationController: UINavigationController?
    var viewFactoryBuilder: BuilderProtocol?
    
    init(navigationController: UINavigationController?, viewFactoryBuilder: BuilderProtocol){
        self.navigationController = navigationController
        self.viewFactoryBuilder = viewFactoryBuilder
    }
    
    func start() {
        showItunesModule()
    }
    
    private func showItunesModule(){
        guard let controller = viewFactoryBuilder?.createItunesView(delegate: self) else { return }
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func showDetailSongsModule(infoSong: Items?){
        guard let controller = viewFactoryBuilder?.createDetailSongsView(infoSong: infoSong) else { return }
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension ItunesSearchCoordinator: ItunesSearchPresenterDeleegate{
    func didSelectSong(infoSong: Items?) {
        showDetailSongsModule(infoSong: infoSong)
    }
}






