//
//  ViewBuilder.swift
//  SearchItunes
//
//  Created by USER on 26.09.2023.
//


import UIKit
//protocol ItunesViewFactory {
//    func makeItunesPresenter() -> ItunesViewPresenterProtocol
//    func makeDetailSongViewController() -> UIViewController
//}
//
//
//class AssamblyItunesViewFactory: ItunesViewFactory{
//    func makeItunesPresenter() -> ItunesViewPresenterProtocol {
//        let networkService = makeNetworkService()
//        return ItunesVCPresenter(networkService: networkService)
//    }
//
//    func makeDetailSongViewController() -> UIViewController {
//        let itunesViewController = ItunesViewController()
//        // нужно будет добавить presenter.viewItunes = view
//        //itunesViewController.presenterItunes = makeItunesPresenter()
//        return itunesViewController
//    }
//
//    private func makeNetworkService() -> Manager {
//        return NetworkManager()
//    }
//}

protocol BuilderProtocol{
    func createItunesView(delegate: ItunesSearchPresenterDeleegate) -> UIViewController
    func createDetailSongsView(infoSong: Items?) -> UIViewController
}

class ViewControlerBuilder: BuilderProtocol {
    func createItunesView(delegate: ItunesSearchPresenterDeleegate ) -> UIViewController {
        let view = ItunesViewController()
        let networkService = NetworkManager()
        let presenter = ItunesVCPresenter(networkService: networkService, view: view, delegate: delegate)
        view.presenterItunes = presenter
        return view
    }
    
     func createDetailSongsView(infoSong: Items?) -> UIViewController {
        let view = DetailSongsViewController()
        let networkService = NetworkManager()
        let presenter = DatailSongsVCPresenter(networkService: networkService, view: view, songInfo: infoSong)
        view.presenterDetails = presenter
        return view
    }
}
