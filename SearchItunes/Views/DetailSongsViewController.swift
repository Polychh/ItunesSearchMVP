//
//  DetailSongsViewController.swift
//  SearchItunes
//
//  Created by USER on 26.09.2023.
//

import UIKit

class DetailSongsViewController: UIViewController {
    
    var detailItunesImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 2
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let detailTrackNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray5
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.minimumScaleFactor = 0.75
        return label
    }()
    
    let detailArtistNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray5
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.minimumScaleFactor = 0.75
        return label
    }()
    
    lazy var stackViewV: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        stack.axis = .vertical
        stack.spacing = 5.0
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(detailArtistNameLabel)
        stack.addArrangedSubview(detailTrackNameLabel)
        return stack
    }()
    
    let detailButtonPlay: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 3
        button.setTitle("Play", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.6403500438, green: 0.8327332139, blue: 0.8568341136, alpha: 1)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let activityIndicatorDetail = ItunesActivityIndicator(frame: .zero)
    
    var presenterDetails: DatailSongVCPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.1083840653, green: 0.2951095104, blue: 0.324511826, alpha: 1)
        setConstrains()
        addTarget()
        presenterDetails.setInfoSongs()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func addTarget(){
        detailButtonPlay.addTarget(self, action: #selector(detailButtonPlayTapped), for: .touchUpInside)
    }
    
    @objc func detailButtonPlayTapped(){
        presenterDetails?.pressedPlayButton()
    }
}
//MARK: - Layout
extension DetailSongsViewController{
    func setConstrains(){
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
        presenterDetails.downloadImageDetailVC(urlImage: infoSongs?.artworkUrl60 ?? Constant.defaultURL, urlSong: infoSongs!.previewUrl)
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
