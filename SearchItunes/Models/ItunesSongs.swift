//
//  IttunesSongs.swift
//  SearchItunes
//
//  Created by USER on 26.09.2023.
//


import Foundation

struct ItunesSongs: Codable {
    let results: [Items]
}

struct Items: Codable{
    let artistName: String?
    let trackCensoredName: String?
    let artworkUrl60: String?
    let previewUrl: String
}
