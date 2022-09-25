//
//  MovieModel.swift
//  newsapi_project
//
//  Created by Ardyan on 24/09/22.
//

import Foundation

// MARK: - Movie Model
struct MovieResultModel: Codable {
    var page: Int?
    var totalPages: Int?
    var results: [MovieModel]?
    
    enum CodingKeys: String, CodingKey {
        case totalPages = "total_pages"
        case page, results
    }
}

// MARK: - Movie Model
struct MovieModel: Codable {
    var id: Int?
    var posterPath: String?
    var title: String?
    var overview: String?
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case overview, id, title
    }
}

// MARK: - Movie Model
struct MovieDetailModel: Codable {
    var id: Int?
    var posterPath: String?
    var title: String?
    var overview: String?
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case overview, title, id
    }
}
