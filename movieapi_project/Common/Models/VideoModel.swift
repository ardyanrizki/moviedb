//
//  VideoModel.swift
//  movieapi_project
//
//  Created by Ardyan on 25/09/22.
//

import Foundation

struct VideoResultModel: Codable {
    var id: Int?
    var results: [VideoModel]?
}

struct VideoModel: Codable {
    var name: String?
    var key: String?
    var site: String?
    var type: String?
}
