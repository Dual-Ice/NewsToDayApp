//
//  NewsManager.swift
//  NewsToDayApp
//
//  Created by  Maksim Stogniy on 19.03.2024.
//

import Foundation
struct NewsRequest {
    var query: String?
    var categories: [String] = []
    var size: Int = 10
    var page: String?
}

class NewsManager: NetworkManager {
    private let apiUrl = "https://newsdata.io/api/1/news"
    private let apiKey = ProcessInfo.processInfo.environment["API_KEY"] ?? ""
    
    func getNews(with request: NewsRequest, completion: @escaping (Result<Response, Error>) -> Void) {
        
        let url = prepareUrl(request)
        
        guard let url else {return}
        loadDataFromUrl(url) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let questionData = try decoder.decode(Response.self, from: data)
                    completion(.success(questionData))
                } catch let error as NSError {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
    private func prepareUrl(_ request: NewsRequest) -> URL? {
        let language = LanguagesService.getCurrentLanguageCodeForRequest()
        var urlString = "\(apiUrl)?apikey=\(apiKey)&language=\(language)&image=1&video=0&size=\(request.size)"
        if (!request.categories.isEmpty) {
            let categoriesString = request.categories.joined(separator: ",")
            urlString = "\(urlString)&category=\(categoriesString)"
        }
        
        if (request.query != nil && request.query!.isEmpty) {
            urlString = "\(urlString)&q=\(request.query!)"
        }
        
        return URL(string: urlString)
    }
}
