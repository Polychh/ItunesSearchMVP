//
//  UIViewController + Ext.swift
//  SearchItunes
//
//  Created by USER on 26.09.2023.
//

import UIKit

extension UIViewController{
    func presentItunesAleretOnMainThread(title: String, message: String, buttonTitle: String){
        DispatchQueue.main.async {
            let alertVC = ItunesAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}
