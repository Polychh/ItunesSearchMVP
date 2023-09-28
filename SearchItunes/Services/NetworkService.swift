//
//  NetworkService.swift
//  SearchItunes
//
//  Created by USER on 26.09.2023.
//

import Foundation

protocol Manager{
    func getSongsInfo( for nameSong: String, completed: @escaping (Result<[Items], ItunesError>) -> Void)
    func downloadImage(from urlString: String, completed: @escaping(Data?) -> Void)
}

class NetworkManager: Manager{
    
    private let baseURL = "https://itunes.apple.com/search?term="
    
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
                let decoder = JSONDecoder()
                let decodeData = try decoder.decode(ItunesSongs.self, from: data)
                
                completed(.success(decodeData.results))
                print(decodeData.results)
            }catch{
                completed(.failure(.invalidData))
            }
            
        }
        task.resume()
    }
    
    func downloadImage(from urlString: String, completed: @escaping(Data?) -> Void){
        guard let url = URL(string: urlString) else {
            print("Error download")
            completed(nil) 
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {  (data, response, error) in
            if let _ = error{
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                print("Error reaponse")
                return
            }
            guard let data = data else{
                print("error data")
                return
            }
            completed(data)
        }
        task.resume()
    }
}
