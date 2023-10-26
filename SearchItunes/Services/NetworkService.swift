//
//  NetworkService.swift
//  SearchItunes
//
//  Created by USER on 26.09.2023.
//

import Foundation

protocol Manager{
    func getSongsInfo( for nameSong: String, completed: @escaping (Result<[Items], ItunesError>) -> Void)
    func downloadImage(from urlString: String, completed: @escaping(Result<Data, ItunesError>) -> Void)
}

final class NetworkManager: Manager{
    
    private let baseURL = "https://itunes.apple.com/search?term="
    private let decoder = JSONDecoder()
    
    func getSongsInfo( for nameSong: String, completed: @escaping (Result<[Items], ItunesError>) -> Void){ //result type
        let endpoint = baseURL+"\(nameSong)&entity=song&attribute=songTerm"
        
        guard let url = URL(string: endpoint) else { //check we get valid URL
            completed(.failure(.invalidNameSong))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in // create url session
            if let _ = error{
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else{
                completed(.failure(.invalidDataFromServer))
                return
            }
            
            do { // parsing json
                let decodeData = try self.decoder.decode(ItunesSongs.self, from: data)
                completed(.success(decodeData.results))
            }catch{
                completed(.failure(.invalidData))
            }
            
        }
        task.resume()
    }
    
    func downloadImage(from urlString: String, completed: @escaping(Result<Data, ItunesError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completed(.failure(.invalidImageURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {  (data, response, error) in
            if let _ = error {
                completed(.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                completed(.failure(.invalidResponse))
                return
            }
                       
            print("Thread imagedownload: \(Thread.current)")
            guard let data = data else{
                completed(.failure(.invalidDataFromServer))
                return
            }
            completed(.success(data))
           
        }
        task.resume()
    }
}
