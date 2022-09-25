//
//  ReviewModel.swift
//  newsapi_project
//
//  Created by Ardyan on 24/09/22.
//

import Foundation

// MARK: - Review Model
struct ReviewResultModel: Codable {
    var id: Int?
    var page: Int?
    var results: [ReviewModel]?
    var totalPages: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, page, results
        case totalPages = "total_pages"
    }
}

// MARK: - Movie Item Model
struct ReviewModel: Codable {
    var id: String?
    var author: String?
    var content: String?
    
    enum CodingKeys: String, CodingKey {
        case id, author, content
    }
}
