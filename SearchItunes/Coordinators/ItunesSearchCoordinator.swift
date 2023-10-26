//
//  Router.swift
//  SearchItunes
//
//  Created by USER on 04.10.2023.
//

import UIKit

//typealias CoordinatorHandler = () -> ()

protocol Coordinator: AnyObject { //для всех координаторов базовый протокол
    var navigationController: UINavigationController? {get}
    //var flowComplitionHandler: CoordinatorHandler? // если несколько flow, для обработки завершениия flow
    func start() // начинается flow
    
}

protocol ItunesSearchCoordinatorProtocol: Coordinator {
    var viewBuilder: BuilderProtocol? {get}
}

protocol ItunesSearchPresenterDelegate: AnyObject{
    func didSelectSong(infoSong: Items?)
}

final class ItunesSearchCoordinator: ItunesSearchCoordinatorProtocol {  // роутинг будет происходить из презентера в презентер
    let navigationController: UINavigationController?
    let viewBuilder: BuilderProtocol?
    
    init(navigationController: UINavigationController?, viewBuilder: BuilderProtocol){
        self.navigationController = navigationController
        self.viewBuilder = viewBuilder
    }
    
    func start() {
        showItunesModule()
    }
    
    private func showItunesModule(){
        guard let controller = viewBuilder?.createItunesView(delegate: self) else { return }
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func showDetailSongsModule(infoSong: Items?){
        guard let controller = viewBuilder?.createDetailSongsView(infoSong: infoSong) else { return }
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension ItunesSearchCoordinator: ItunesSearchPresenterDelegate{
    func didSelectSong(infoSong: Items?) {
        showDetailSongsModule(infoSong: infoSong)
    }
}






