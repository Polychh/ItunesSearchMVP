//
//  ItunesVCPresenter.swift
//  SearchItunes
//
//  Created by USER on 26.09.2023.
//

import Foundation

protocol ItunesViewProtocol: AnyObject{
    func reloadTableView()
    func failure(error: ItunesError)
    func emptyArray()
    func dissmisLoadingView()
    func startLoadinView()
}

protocol ItunesViewPresenterProtocol: AnyObject {
    init(networkService: Manager, view: ItunesViewProtocol?, delegate: ItunesSearchPresenterDelegate?)
    func getSongs(songName:String)
    func cleanTableView()
    func setDismissLoadingView()
    func reloadTableView()
    func tapOnTheSong(infoSong: Items?)
    var songs: [Items] {get set}
    var dataImage: [Int:Data] {get set}
}

final class ItunesVCPresenter: ItunesViewPresenterProtocol {
    
    let networService: Manager
    weak var viewItunes: ItunesViewProtocol?
    var songs: [Items] = []
    var dataImage: [Int:Data] = [:]
    weak var delegate: ItunesSearchPresenterDelegate?
        
    required init(networkService: Manager, view: ItunesViewProtocol?, delegate: ItunesSearchPresenterDelegate?) {
        self.networService = networkService
        self.viewItunes = view
        self.delegate = delegate
    }
    
    func getSongs(songName: String) {
        let group = DispatchGroup()
        networService.getSongsInfo(for: songName) { [weak self] results in
            guard let self = self else { return }
            self.dataImage = [:]// clean diictionary every new request
            self.viewItunes?.startLoadinView()
            print("Thread1 \(Thread.current)")
            switch results{
            case .success(let songsArray):
                print(songsArray)
                print("Thread1 \(Thread.current)")
                self.songs = songsArray
                if songsArray.isEmpty{
                    self.viewItunes?.dissmisLoadingView()
                    self.viewItunes?.emptyArray()
                    self.viewItunes?.reloadTableView()
                } else{
                    for song in self.songs{
                            group.enter()
                        self.networService.downloadImage(from: song.artworkUrl60 ?? Constant.defaultURL) { (result) in
                            switch result{
                            case.success(let data):
                                print("Thread2 \(Thread.current)")
                                self.dataImage[song.trackId] = data
                                group.leave()
                            case .failure(let error):
                                self.viewItunes?.failure(error: error)
                            }
                        }
                        group.notify(queue: .main){
                            self.viewItunes?.dissmisLoadingView()
                            self.viewItunes?.reloadTableView()
                        }
                    }
                }
            case .failure(let error):
                self.viewItunes?.failure(error: error)
                self.viewItunes?.reloadTableView()
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
        delegate?.didSelectSong(infoSong: infoSong)
    }
    
    func reloadTableView(){
        viewItunes?.reloadTableView()
    }
}


