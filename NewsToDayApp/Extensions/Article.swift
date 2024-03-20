//
//  NewsEntity.swift
//  NewsToDayApp
//
//  Created by  Maksim Stogniy on 19.03.2024.
//

import Foundation

struct Response: Codable {
    var results: [Article]?
}

struct Article: Codable {
    let articleId: String
    let title: String
    let description: String?
    let imageUrl: String?
    let category: [String]
    let creator: [String]?
    var isFavourite: Bool
    
    private enum CodingKeys: String, CodingKey {
        case articleId
        case title
        case description
        case imageUrl
        case category
        case creator
        case isFavourite
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        articleId = try container.decode(String.self, forKey: .articleId)
        title = try container.decode(String.self, forKey: .title)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl)
        category = try container.decode([String].self, forKey: .category)
        creator = try container.decodeIfPresent([String].self, forKey: .creator)
        isFavourite = false
    }
}
