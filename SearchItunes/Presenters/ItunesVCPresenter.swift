//
//  ItunesVCPresenter.swift
//  SearchItunes
//
//  Created by USER on 26.09.2023.
//

import Foundation

protocol ItunesViewProtocol: AnyObject{
    func success()
    func failure(error: ItunesError)
    func emptyErray()
    func dissmisLoadingView()
    func startLoadinView()
}

protocol ItunesViewPresenterProtocol: AnyObject {
    init(networkService: Manager)
    func getSongs(songName:String)
    func downloadImage(urlImage: String,completed: @escaping (Data) -> Void)
    func cleanTableView()
    func setDismissLoadingView()
    var songs: [Items]? {get set}
}

class ItunesVCPresenter: ItunesViewPresenterProtocol {
    var networService: Manager
    weak var viewItunes: ItunesViewProtocol?
    var songs: [Items]?
    
    required init(networkService: Manager) {
        self.networService = networkService
    }
    
    func getSongs(songName: String) {
        networService.getSongsInfo(for: songName) { [weak self] results in
            guard let self = self else { return }
            self.viewItunes?.startLoadinView()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                switch results{
                case .success(let songsArray):
                    self.songs = songsArray
//                    print("songArray \(self.songs)")
//                    print(self.songs?.count)
                    if songsArray.isEmpty{
                        self.viewItunes?.dissmisLoadingView()
                        self.viewItunes?.emptyErray()
                    } else{
                        self.viewItunes?.dissmisLoadingView()
                        self.viewItunes?.success()
                    }

                case .failure(let error):
                    print(error)
                    self.viewItunes?.failure(error: error)
                }
            }
        }
    }
    
    func downloadImage(urlImage: String, completed: @escaping (Data) -> Void) {
        networService.downloadImage(from: urlImage) { (data) in
            guard let data = data else { return } 
            completed(data)
        }
    }
    
    func setDismissLoadingView() {
        viewItunes?.dissmisLoadingView()
    }
    
    func cleanTableView() {
        songs = []
    }
}

