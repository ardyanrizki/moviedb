//
//  GenreModel.swift
//  newsapi_project
//
//  Created by Ardyan on 24/09/22.
//

import Foundation

// MARK: - Genre Result Model
struct GenreResultModel: Codable {
    var genres: [GenreModel]?
}

// MARK: - Genre Model
struct GenreModel: Codable {
    var id: Int?
    var name: String?
}
