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
    init(networkService: Manager, songInfo: Items? )
    func setInfoSongs()
    func downloadImageDetailVC(urlImage: String, urlSong: String)
    func pressedPlayButton()
    var dataFromURLImage: Data {get set}
    var dataFromURLMusic: Data {get set}
}

class DatailSongsVCPresenter: DatailSongVCPresenterProtocol{

    var player: AVAudioPlayer?
    var plaing: Bool = true
    
    weak var detailView: DetailSongsViewProtocol?
    var networkService: Manager
    var infoSong: Items?
    var dataFromURLImage: Data = Data()
    var dataFromURLMusic: Data = Data()
    
    required init(networkService: Manager, songInfo: Items?) {
        self.networkService = networkService
        self.infoSong = songInfo
    }
    
    func setInfoSongs() {
        self.detailView?.startSetInfoSongs(infoSongs: infoSong)
    }
    
    func downloadImageDetailVC(urlImage: String, urlSong: String) {
        let group = DispatchGroup()
    
        networkService.downloadImage(from: urlImage) { (data) in
            self.detailView?.startLoadinView()
            print("Thread5 \(Thread.current)")
            guard let data = data else { return }
            self.dataFromURLImage = data
            self.detailView?.successDownload()
            group.enter()
            self.networkService.downloadImage(from: urlSong) { (data) in
                print("Thread6 \(Thread.current)")
                //sleep(4) // to see how work dispatch group
                guard let data = data else { return }
                self.dataFromURLMusic = data
                group.leave()
            }
            group.notify(queue: .main){
                print("Thread7 \(Thread.current)")
                self.detailView?.dissmisLoadingView()
                DispatchQueue.main.async {
                    self.player = try? AVAudioPlayer(data: self.dataFromURLMusic)
                }
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

