//
//  SearchItunesUIImage.swift
//  SearchItunes
//
//  Created by USER on 26.10.2023.
//

import UIKit

final class SearchItunesUIImage: UIImageView {
    override init(frame: CGRect)  {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        layer.cornerRadius = 2
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
}

