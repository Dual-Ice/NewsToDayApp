//
//  NetworkManager.swift
//  NewsToDayApp
//
//  Created by  Maksim Stogniy on 19.03.2024.
//

import Foundation


class NetworkManager {
    func loadDataFromUrl(_ url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        
        let request = URLRequest(url: url, cachePolicy: .reloadRevalidatingCacheData, timeoutInterval: 10)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...300).contains(httpResponse.statusCode) else {
                completion(.failure(NetworkError.wrongCode))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.notFoundData))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
}
