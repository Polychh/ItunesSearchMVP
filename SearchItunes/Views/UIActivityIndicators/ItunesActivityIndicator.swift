//
//  ItunesActivityIndicator.swift
//  SearchItunes
//
//  Created by USER on 28.09.2023.
//

import UIKit

class ItunesActivityIndicator: UIActivityIndicatorView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(){
        hidesWhenStopped = true
        color = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        style = .large
    }
}


