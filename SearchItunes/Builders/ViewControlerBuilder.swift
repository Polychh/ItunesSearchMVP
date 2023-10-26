//
//  ViewBuilder.swift
//  SearchItunes
//
//  Created by USER on 26.09.2023.
//


import UIKit

protocol BuilderProtocol{
    func createItunesView(delegate: ItunesSearchPresenterDelegate) -> UIViewController
    func createDetailSongsView(infoSong: Items?) -> UIViewController
}

final class ViewControlerBuilder: BuilderProtocol {
    func createItunesView(delegate: ItunesSearchPresenterDelegate ) -> UIViewController {
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
