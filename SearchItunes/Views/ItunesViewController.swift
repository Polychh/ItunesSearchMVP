//
//  ViewController.swift
//  SearchItunes
//
//  Created by USER on 26.09.2023.
//

import UIKit

final class ItunesViewController: UIViewController {
    var presenterItunes: ItunesViewPresenterProtocol!
    
    private let searchTextField = SearchTextField()
    private let tableView = UITableView()
    private let activityIndicator = ItunesActivityIndicator(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        setConstrains()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchTextField.text = ""
        navigationController?.setNavigationBarHidden(true, animated: true) //hide navigationbar
        
    }
    private func setDelegates(){
        searchTextField.delegate = self
    }
    
    private func configureTableView() {
        tableView.rowHeight = 60
        tableView.backgroundColor = #colorLiteral(red: 0.8039215686, green: 0.9607843137, blue: 0.9921568627, alpha: 1)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableSongsCell.self, forCellReuseIdentifier: TableSongsCell.resuseID)
    }
}
//MARK: - Layout
extension ItunesViewController{
    private func setConstrains(){
        view.backgroundColor = #colorLiteral(red: 0.4310129881, green: 0.6814386249, blue: 0.7116398215, alpha: 1)
        
        view.addSubview(searchTextField)
        view.addSubview(tableView)
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20), //right
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20), //left
            searchTextField.heightAnchor.constraint(equalToConstant: 70),
            
            tableView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0), //right
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0), //left
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
        ])
    }
}
//MARK: - UITextFieldDelegate
extension ItunesViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { // for "go" button on keyboard
        presenterItunes.cleanTableView()
        print(textField.text!)
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" && textField.text!.count > 3 { // validation what user typed
            presenterItunes.getSongs(songName: textField.text!)
            return true
        } else {
            presenterItunes.setDismissLoadingView()
            presenterItunes.cleanTableView()
            presenterItunes.reloadTableView()
            presentItunesAleretOnMainThread(title: "Type something", message: "Your textfield is empty or you typing less than 3 characters, please, type more!", buttonTitle: "OK")
            return false
        }
    }
}
//MARK: - UITableViewDelegate, UITableViewDataSource
extension ItunesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenterItunes.songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableSongsCell.resuseID, for: indexPath) as? TableSongsCell else {
            return UITableViewCell()
        }
        
        let songInfo = presenterItunes.songs[indexPath.row]
        cell.congigureArtistName(artistName: songInfo.artistName)
        cell.congigureTrackName(trackName: songInfo.trackCensoredName)
        let imageInfo = presenterItunes.songs[indexPath.row].trackId
        if let imageData = presenterItunes.dataImage[imageInfo]{
            cell.congigureAlbumView(albumView: UIImage(data: imageData))
        }else{
            cell.congigureAlbumView(albumView: UIImage(named: Constant.defaultImage))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let infoSong = presenterItunes.songs[indexPath.row]
        presenterItunes.tapOnTheSong(infoSong: infoSong)
    }
}
//MARK: - Update TableView
extension ItunesViewController: ItunesViewProtocol{
    func startLoadinView() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
    }
    
    func dissmisLoadingView() {
        DispatchQueue.main.async() {
            self.activityIndicator.stopAnimating()
        }
    }
    
    func reloadTableView() {
        DispatchQueue.main.async() {
            self.tableView.reloadData()
        }
    }
    
    func failure(error: ItunesError) {
        presenterItunes.setDismissLoadingView()
        presentItunesAleretOnMainThread(title: "Error", message: error.rawValue, buttonTitle: "Ok")
        searchTextField.text = ""
    }
    
    func emptyArray() {
        presentItunesAleretOnMainThread(title: "Incorrect song name", message: "Nothing found, Please, try again", buttonTitle: "Ok")
        DispatchQueue.main.async() {
            self.searchTextField.text = ""
        }
    }
}
