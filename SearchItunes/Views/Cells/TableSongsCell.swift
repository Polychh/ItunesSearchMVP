//
//  TableSongsCell.swift
//  SearchItunes
//
//  Created by USER on 26.09.2023.
//

import UIKit

final class TableSongsCell: UITableViewCell {
    static let resuseID = "TableSongsCell"
    
    private let artistNameLabel = SearchItunesUILabel(textAlignment: .center, fontSize: 15, textColor: .secondaryLabel)
    private let trackNameLabel = SearchItunesUILabel(textAlignment: .center, fontSize: 15, textColor: .secondaryLabel)
    private let itunesImageView = SearchItunesUIImage(frame: .zero)
    
    lazy private var stackViewH: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5.0
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(artistNameLabel)
        stack.addArrangedSubview(trackNameLabel)
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        self.backgroundColor = #colorLiteral(red: 0.8039215686, green: 0.9607843137, blue: 0.9921568627, alpha: 1)
        addSubview(itunesImageView)
        addSubview(stackViewH)
                  
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            itunesImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor), // set verticaly in the cell
            itunesImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            itunesImageView.heightAnchor.constraint(equalToConstant: 60),
            itunesImageView.widthAnchor.constraint(equalToConstant: 60),
            
            stackViewH.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stackViewH.leadingAnchor.constraint(equalTo: itunesImageView.trailingAnchor, constant: 24),
            stackViewH.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            stackViewH.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    func congigureArtistName(artistName: String){
        artistNameLabel.text = artistName
    }
    
    func congigureTrackName(trackName: String){
        trackNameLabel.text = trackName
    }
    
    func congigureAlbumView(albumView: UIImage?){
        itunesImageView.image = albumView
    }
}
