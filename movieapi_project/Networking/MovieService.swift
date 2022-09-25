//
//  MovieService.swift
//  movieapi_project
//
//  Created by Ardyan on 24/09/22.
//

import Foundation

class MovieService: GenreServiceProtocol {
    
    static let shared = MovieService()
    
    func getGenreList(success: @escaping (GenreResultModel) -> Void, failure: @escaping (NSError) -> Void) {
        guard let url = URL(string: Endpoints.getGenreList) else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        Service.shared.performRequest(urlRequest: urlRequest,
                                      expectingReturnType: GenreResultModel.self,
                                      success: { result in success(result)},
                                      failure: { error in failure(error)})
    }
    
    func getMovieList(by genreId: Int, page: Int, success: @escaping (MovieResultModel) -> Void, failure: @escaping (NSError) -> Void) {
        guard let url = URL(string: Endpoints.getMovieListByGenre(id: genreId, page: page)) else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        Service.shared.performRequest(urlRequest: urlRequest,
                                      expectingReturnType: MovieResultModel.self,
                                      success: { result in success(result)},
                                      failure: { error in failure(error)})
    }
    
    func getMovieDetail(by movieId: Int, success: @escaping (MovieDetailModel) -> Void, failure: @escaping (NSError) -> Void) {
        guard let url = URL(string: Endpoints.getMovieDetail(id: movieId)) else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        Service.shared.performRequest(urlRequest: urlRequest,
                                      expectingReturnType: MovieDetailModel.self,
                                      success: { result in success(result)},
                                      failure: { error in failure(error)})
    }
    
    func getReviewList(by movieId: Int, page: Int, success: @escaping (ReviewResultModel) -> Void, failure: @escaping (NSError) -> Void) {
        guard let url = URL(string: Endpoints.getReviewListByMovie(id: movieId, page: page)) else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        Service.shared.performRequest(urlRequest: urlRequest,
                                      expectingReturnType: ReviewResultModel.self,
                                      success: { result in success(result)},
                                      failure: { error in failure(error)})
    }
    
    func getVideoList(by movieId: Int, success: @escaping (VideoResultModel) -> Void, failure: @escaping (NSError) -> Void) {
        guard let url = URL(string: Endpoints.getVideoListByMovie(id: movieId)) else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        Service.shared.performRequest(urlRequest: urlRequest,
                                      expectingReturnType: VideoResultModel.self,
                                      success: { result in success(result)},
                                      failure: { error in failure(error)})
    }
    
}

protocol GenreServiceProtocol {
    func getGenreList(success: @escaping (GenreResultModel) -> Void, failure: @escaping (NSError) -> Void)
    func getMovieList(by genreId: Int, page: Int, success: @escaping (MovieResultModel) -> Void, failure: @escaping (NSError) -> Void)
    func getMovieDetail(by movieId: Int, success: @escaping (MovieDetailModel) -> Void, failure: @escaping (NSError) -> Void)
    func getReviewList(by movieId: Int, page: Int, success: @escaping (ReviewResultModel) -> Void, failure: @escaping (NSError) -> Void)
    func getVideoList(by movieId: Int, success: @escaping (VideoResultModel) -> Void, failure: @escaping (NSError) -> Void)
}
