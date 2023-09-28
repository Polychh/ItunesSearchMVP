//
//  ItunesError.swift
//  SearchItunes
//
//  Created by USER on 26.09.2023.
//

import Foundation

enum ItunesError: String, Error{
    case invalidNameSong = "This nameSong created an invalid request. Please try again"
    case unableToComplete = "Unable to complete request. Please check your internet connection"
    case invalidResponse = "Invalid response from the server. Please try again"
    case invalidData = "The data received from the server was invalid. Please try again"
    case invalidDataFromServer = " The The data received from the server was invalid. Please try again"
}
