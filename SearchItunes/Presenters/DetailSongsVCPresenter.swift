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
}

protocol DatailSongVCPresenterProtocol: AnyObject{
    init(networkService: Manager, songInfo: Items? )
    func setInfoSongs()
    func downloadImageDetailVC(urlImage: String, completed: @escaping (Data) -> Void)
    func downloadSongsDetailVC(urlSong: String)
    func pressedPlayButton()
}

class DatailSongsVCPresenter: DatailSongVCPresenterProtocol{

    var player: AVAudioPlayer?
    var plaing: Bool = true
    
    weak var detailView: DetailSongsViewProtocol?
    var networkService: Manager
    var infoSong: Items?
    
    required init(networkService: Manager, songInfo: Items?) {
        self.networkService = networkService
        self.infoSong = songInfo
    }
    
    func setInfoSongs() {
        self.detailView?.startSetInfoSongs(infoSongs: infoSong)
    }
    
    func downloadImageDetailVC(urlImage: String, completed: @escaping (Data) -> Void) {
        networkService.downloadImage(from: urlImage) { (data) in
            guard let data = data else { return }
            completed(data)
        }
    }
    
    func downloadSongsDetailVC(urlSong: String) {
        networkService.downloadImage(from: urlSong) { (data) in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.player = try? AVAudioPlayer(data: data)
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
