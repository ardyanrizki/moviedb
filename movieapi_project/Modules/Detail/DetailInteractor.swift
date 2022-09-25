//
//  DetailInteractor.swift
//  movieapi_project
//
//  Created by Ardyan on 25/09/22.
//  
//

import Foundation

class DetailInteractor: PresenterToInteractorDetailProtocol {

    // MARK: Properties
    var presenter: InteractorToPresenterDetailProtocol?
    
    func fetchMovieDetail(with movieId: Int) {
        MovieService.shared.getMovieDetail(by: movieId, success: { [weak self] data in
            self?.presenter?.fetchMovieDetailDidSuccess(data: data)
        }, failure: { [weak self] error in
            self?.presenter?.fetchMovieDetailDidFail(error: error)
        })
    }
}
