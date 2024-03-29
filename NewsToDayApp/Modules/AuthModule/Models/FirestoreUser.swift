//
//  FirestoreUser.swift
//  NewsToDayApp
//
//  Created by Vasilii Pronin on 25.03.2024.
//

import Foundation

struct FirestoreUser {
    
    let username: String
    let email: String
    let userID: String
    var image: String
    var categories: [String]
    var articles: [Article]
    
}

extension FirestoreUser: Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        username = try container.decode(String.self, forKey: .username)
        email = try container.decode(String.self, forKey: .email)
        userID = try container.decode(String.self, forKey: .userID)
        image = try container.decode(String.self, forKey: .image)
        categories = try container.decode([String].self, forKey: .categories)
        articles = try container.decode([Article].self, forKey: .articles)
    }
}

extension FirestoreUser {
    func toJSON() throws -> Data {
        return try JSONEncoder().encode(self)
    }
}
