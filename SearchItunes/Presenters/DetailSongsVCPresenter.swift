//
//  DetailSongsVCPresenter.swift
//  SearchItunes
//
//  Created by USER on 26.09.2023.
//

import Foundation
import AVFoundation

protocol DetailSongsViewProtocol: AnyObject{
    func startSetInfoSongs(infoSongs: Items?)
    func successDownload()
    func startLoadinView()
    func dissmisLoadingView()
}

protocol DatailSongVCPresenterProtocol: AnyObject{
    init(networkService: Manager,view: DetailSongsViewProtocol?, songInfo: Items?)
    func setInfoSongs()
    func downloadImageDetailVC(urlImage: String, urlSong: String)
    func pressedPlayButton()
    var dataFromURLImage: Data {get set}
    var dataFromURLMusic: Data {get set}
}

final class DatailSongsVCPresenter: DatailSongVCPresenterProtocol{

    private var player: AVAudioPlayer?
    private var plaing: Bool = true
    
    weak var detailView: DetailSongsViewProtocol?
    let networkService: Manager
    var infoSong: Items?
    var dataFromURLImage: Data = Data()
    var dataFromURLMusic: Data = Data()
    
    required init(networkService: Manager, view: DetailSongsViewProtocol?, songInfo: Items?) {
        self.networkService = networkService
        self.detailView = view
        self.infoSong = songInfo
    }
    
    func setInfoSongs() {
        self.detailView?.startSetInfoSongs(infoSongs: infoSong)
    }
    
    func downloadImageDetailVC(urlImage: String, urlSong: String) {
        let group = DispatchGroup()
        networkService.downloadImage(from: urlImage) { (result) in
            self.detailView?.startLoadinView()
            group.enter()
            switch result{
            case .success(let data):
                self.dataFromURLImage = data
                self.detailView?.successDownload()
                self.networkService.downloadImage(from: urlSong) { (result) in
                    switch result{
                    case .success(let data):
                        print("Thread6 \(Thread.current)")
                        //sleep(4) // to see how work dispatch group
                        self.dataFromURLMusic = data
                        group.leave()
                    case .failure(let error):
                        print(error)
                    }
                }
                group.notify(queue: .main){
                    print("Thread7 \(Thread.current)")
                    self.detailView?.dissmisLoadingView()
                    DispatchQueue.main.async {
                        self.player = try? AVAudioPlayer(data: self.dataFromURLMusic)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func pressedPlayButton() {
        if (plaing == true){
            player?.play()
            plaing = !plaing
        } else{
            player?.stop()
            plaing = !plaing
        }
    }
}

