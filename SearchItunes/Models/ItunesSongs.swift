//
//  IttunesSongs.swift
//  SearchItunes
//
//  Created by USER on 26.09.2023.
//


import Foundation

struct ItunesSongs: Decodable {
    let results: [Items]
}

struct Items: Decodable{
    let artistName: String
    let trackCensoredName: String
    let artworkUrl60: String?
    let previewUrl: String?
    let trackId: Int
}
