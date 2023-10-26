//
//  DetailSongsViewController.swift
//  SearchItunes
//
//  Created by USER on 26.09.2023.
//

import UIKit

final class DetailSongsViewController: UIViewController {
    
    private let detailItunesImageView = SearchItunesUIImage(frame: .zero)
    private let detailTrackNameLabel = SearchItunesUILabel(textAlignment: .center, fontSize: 17, textColor: .systemGray5)
    private let detailArtistNameLabel = SearchItunesUILabel(textAlignment: .center, fontSize: 17, textColor: .systemGray5)
    private let detailButtonPlay = SarchItunesUIButton(backgroundColor: #colorLiteral(red: 0.6403500438, green: 0.8327332139, blue: 0.8568341136, alpha: 1), title: "Play")
    private let activityIndicatorDetail = ItunesActivityIndicator(frame: .zero)
    private let stackViewV = UIStackView()
    
    var presenterDetails: DatailSongVCPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstrains()
        setScrollView()
        addTarget()
        presenterDetails.setInfoSongs()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func setScrollView(){
        stackViewV.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        stackViewV.axis = .vertical
        stackViewV.spacing = 5.0
        stackViewV.alignment = .fill
        stackViewV.distribution = .fillEqually
        stackViewV.translatesAutoresizingMaskIntoConstraints = false
        stackViewV.addArrangedSubview(detailArtistNameLabel)
        stackViewV.addArrangedSubview(detailTrackNameLabel)
    }
    
    private func addTarget(){
        detailButtonPlay.addTarget(self, action: #selector(detailButtonPlayTapped), for: .touchUpInside)
    }
    
    @objc private func detailButtonPlayTapped(){
        presenterDetails?.pressedPlayButton()
    }
}
//MARK: - Layout
extension DetailSongsViewController{
    private func setConstrains(){
        view.backgroundColor = #colorLiteral(red: 0.1083840653, green: 0.2951095104, blue: 0.324511826, alpha: 1)
        view.addSubview(detailItunesImageView)
        view.addSubview(stackViewV)
        view.addSubview(detailButtonPlay)
        activityIndicatorDetail.center = view.center
        view.addSubview(activityIndicatorDetail)
        
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            detailItunesImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            detailItunesImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            detailItunesImageView.widthAnchor.constraint(equalToConstant: 200),
            detailItunesImageView.heightAnchor.constraint(equalToConstant: 200),
            
            stackViewV.topAnchor.constraint(equalTo: detailItunesImageView.bottomAnchor, constant: padding),
            stackViewV.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackViewV.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackViewV.heightAnchor.constraint(equalToConstant: 60),
            
            detailButtonPlay.topAnchor.constraint(equalTo: stackViewV.bottomAnchor, constant: 20),
            detailButtonPlay.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            detailButtonPlay.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            detailButtonPlay.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}
//MARK: - ListenPresenter vc is delegate for presenter
extension DetailSongsViewController: DetailSongsViewProtocol{

    func startSetInfoSongs(infoSongs: Items?) {
        detailTrackNameLabel.text = infoSongs?.trackCensoredName
        detailArtistNameLabel.text = infoSongs?.artistName
        if let previewUrl = infoSongs?.previewUrl{
            guard let urlImage = infoSongs?.artworkUrl60 else{
                detailItunesImageView.image = UIImage(named: Constant.defaultImage)
                return
            }
            presenterDetails.downloadImageDetailVC(urlImage: urlImage, urlSong: previewUrl)
        } else{
            presentItunesAleretOnMainThread(title: "Error download", message: "Can not download song, please, try another songs", buttonTitle: "Ok")
        }
    }
    
    func successDownload() {
        DispatchQueue.main.async{
            self.detailItunesImageView.image = UIImage(data: self.presenterDetails.dataFromURLImage)
        }
    }
    
    func startLoadinView() {
        DispatchQueue.main.async {
            self.activityIndicatorDetail.startAnimating()
        }
    }
    
    func dissmisLoadingView() {
        DispatchQueue.main.async() {
            self.activityIndicatorDetail.stopAnimating()
        }
    }
}
