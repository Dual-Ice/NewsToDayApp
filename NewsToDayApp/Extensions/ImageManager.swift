//
//  ImageManager.swift
//  NewsToDayApp
//
//  Created by  Maksim Stogniy on 19.03.2024.
//

import UIKit

class ImageManager: NetworkManager {
    var imageCache: [String: UIImage] = [:]
    
    func getImage(for url: String?, completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let url = url else { return }
        if let cachedImage = imageCache[url] {
            completion(.success(cachedImage))
        }
        
        loadAndCacheImage(url, completion: completion)
    }

    private func loadAndCacheImage(_ urlString: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.wrongUrl))
            return
        }
        
        loadDataFromUrl(url) { result in
            switch result {
            case .success(let data):
                if let downloadedImage = UIImage(data: data) {
                    self.imageCache[urlString] = downloadedImage
                    completion(.success(downloadedImage))
                } else {
                    completion(.failure(NetworkError.invalidImageData))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
