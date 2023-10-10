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
    init(networkService: Manager, view: ItunesViewProtocol?, delegate: ItunesSearchPresenterDeleegate)
    func getSongs(songName:String)
    func cleanTableView()
    func setDismissLoadingView()
    func tapOnTheSong(infoSong: Items?)
    var songs: [Items]? {get set}
    var dataImage: [Data] {get set}
}

class ItunesVCPresenter: ItunesViewPresenterProtocol {
    
    var networService: Manager
    weak var viewItunes: ItunesViewProtocol?
    var songs: [Items]?
    var dataImage: [Data] = []
    var delegate: ItunesSearchPresenterDeleegate
        
    required init(networkService: Manager, view: ItunesViewProtocol?, delegate: ItunesSearchPresenterDeleegate  ) {
        self.networService = networkService
        self.viewItunes = view
        self.delegate = delegate
    }
    
    func getSongs(songName: String) {
        let group = DispatchGroup()
        networService.getSongsInfo(for: songName) { [weak self] results in
            guard let self = self else { return }
            self.dataImage = [] // clean array every new request
            self.viewItunes?.startLoadinView()
            print("Thread1 \(Thread.current)")
            switch results{
            case .success(let songsArray):
                //print("Count\(songsArray.count)")
                self.songs = songsArray
                if songsArray.isEmpty{
                    self.viewItunes?.dissmisLoadingView()
                    self.viewItunes?.emptyErray()
                } else{
                    if let songs = self.songs{
                        for song in songs{
                            group.enter()
                            self.networService.downloadImage(from: song.artworkUrl60 ?? Constant.defaultURL) { (data) in
                                //sleep(1) // to see how work dispatch group
                                print("Thread3 \(Thread.current)")
                                self.dataImage.append(data)
                                group.leave()
                            }
                        }
                        group.notify(queue: .main){
                            print("Thread4 \(Thread.current)")
                            self.viewItunes?.dissmisLoadingView()
                            self.viewItunes?.success()
                        }
                    }
                }
            case .failure(let error):
                print(error)
                self.viewItunes?.failure(error: error)
            }
        }
    }
    
    
    func setDismissLoadingView() {
        viewItunes?.dissmisLoadingView()
    }
    
    func cleanTableView() {
        songs = []
    }
    
    func tapOnTheSong(infoSong: Items?) {
        delegate.didSelectSong(infoSong: infoSong)
    }
}


