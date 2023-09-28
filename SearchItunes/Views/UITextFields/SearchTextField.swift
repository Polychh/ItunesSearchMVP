//
//  SearchTextField.swift
//  SearchItunes
//
//  Created by USER on 26.09.2023.
//

import UIKit

final class SearchTextField: UITextField{
    
    private let padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    private func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor
        layer.shadowRadius = 7
        layer.shadowOpacity = 0.4
        
        textColor = .label
        tintColor = .label
        textAlignment = .left
        font = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        
        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .no
        
        returnKeyType = .go //changee return to go
        clearButtonMode = .whileEditing // to clear textfield
        placeholder = "Enter song name"
    }
}


