//
//  TableSongsCell.swift
//  SearchItunes
//
//  Created by USER on 26.09.2023.
//

import UIKit

class TableSongsCell: UITableViewCell {
    static let resuseID = "TableSongsCell"
    
    let artistNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.minimumScaleFactor = 0.75
        return label
    }()
    
    let trackNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.minimumScaleFactor = 0.75
        return label
    }()
    
    var itunesImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var stackViewH: UIStackView = {
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func configure(){
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
}
