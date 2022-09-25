//
//  Service.swift
//  newsapi_project
//
//  Created by Ardyan on 24/09/22.
//

import Foundation

struct Constants {
    static let baseUrl = "https://api.themoviedb.org/3"
    static let imageBaseUrl = "https://image.tmdb.org/t/p/w300"
    static let apiKeyQuery = "api_key=c1f3a0d814adabd306669a20af283c7c"
}

struct Endpoints {
    static let getGenreList = "\(Constants.baseUrl)/genre/movie/list?\(Constants.apiKeyQuery)"
    static func getMovieListByGenre(id: Int, page: Int) -> String {
        return "\(Constants.baseUrl)/discover/movie?with_genres=\(id)&page=\(page)&\(Constants.apiKeyQuery)"
    }
    static func getMovieDetail(id: Int) -> String {
        return "\(Constants.baseUrl)/movie/\(id)?\(Constants.apiKeyQuery)"
    }
    static func getReviewListByMovie(id: Int, page: Int) -> String {
        return "\(Constants.baseUrl)/movie/\(id)/reviews?page=\(page)&\(Constants.apiKeyQuery)"
    }
    static func getVideoListByMovie(id: Int) -> String {
        return "\(Constants.baseUrl)/movie/\(id)/videos?\(Constants.apiKeyQuery)"
    }
}

class Service {
    
    static let shared = Service()
    
    let session: URLSession
    let urlCache = URLCache.shared
    
    init() {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.requestCachePolicy = NSURLRequest.CachePolicy.useProtocolCachePolicy
        sessionConfig.urlCache = urlCache
        session = URLSession(configuration: sessionConfig)
    }
    
    
    func performRequest<T: Decodable>(urlRequest: URLRequest,
                                             expectingReturnType: T.Type,
                                             success: @escaping (T) -> Void,
                                             failure: @escaping (NSError) -> Void) {
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            
            guard let responseStatus = response as? HTTPURLResponse, responseStatus.statusCode == 200 else {
                failure(Service.errorSessionTask())
                return
            }
            if let error = error {
                failure(Service.errorSessionTask(error: error))
            }
            else if let data = data {
                do {
                    let decoded = try JSONDecoder().decode(T.self, from: data)
                    success(decoded)
                }
                catch {
                    failure(Service.errorSessionTask(error: error))
                }
            }
        }
        task.resume()
    }
    
    static func errorSessionTask(error: Error? = nil) -> NSError {
        var localizedDescription = "Error request"
        if let error = error {
           localizedDescription = error.localizedDescription
        }
        let userInfo: [String: Any] = [
            NSLocalizedDescriptionKey: localizedDescription,
            NSLocalizedFailureReasonErrorKey: "Error requesting from Server"
        ]
        let error = NSError(domain: "MovieAPI_Project", code: 520, userInfo: userInfo)
        return error
    }
    
}


