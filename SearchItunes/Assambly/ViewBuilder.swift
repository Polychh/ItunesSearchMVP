//
//  ViewBuilder.swift
//  SearchItunes
//
//  Created by USER on 26.09.2023.
//


import UIKit

protocol Builder{
    static func createItunesView() -> UIViewController
    static func createDetailSongsView(infoSong: Items?) -> UIViewController
}

class ViewBuilder: Builder {
    static func createItunesView() -> UIViewController {
        let view = ItunesViewController()
        let networkService = NetworkManager()
        let presenter = ItunesVCPresenter(networkService: networkService)
        presenter.viewItunes = view
        view.presenterItunes = presenter
        return view
    }
    
    static func createDetailSongsView(infoSong: Items?) -> UIViewController {
        let view = DetailSongsViewController()
        let networkService = NetworkManager()
        let presenter = DatailSongsVCPresenter(networkService: networkService, songInfo: infoSong)
        presenter.detailView = view
        view.presenterDetails = presenter
        return view
    }
}
