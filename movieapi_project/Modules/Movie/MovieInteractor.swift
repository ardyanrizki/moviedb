//
//  MovieInteractor.swift
//  movieapi_project
//
//  Created by Ardyan on 25/09/22.
//  
//

import Foundation

class MovieInteractor: PresenterToInteractorMovieProtocol {

    // MARK: Properties
    var presenter: InteractorToPresenterMovieProtocol?
    
    func fetchMovieList(by movieId: Int, page: Int) {
        MovieService.shared.getMovieList(by: movieId, page: page, success: { [weak self] data in
            self?.presenter?.fetchMovieListDidSuccess(data: data)
        }, failure: { [weak self] error in
            self?.presenter?.fetchMovieListDidFail(error: error)
        })
    }
}
