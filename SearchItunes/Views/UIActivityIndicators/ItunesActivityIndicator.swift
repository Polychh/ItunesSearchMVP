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
        //translatesAutoresizingMaskIntoConstraints = false
        hidesWhenStopped = true
        color = #colorLiteral(red: 0.1083840653, green: 0.2951095104, blue: 0.324511826, alpha: 1)
        style = .large
    }
}


