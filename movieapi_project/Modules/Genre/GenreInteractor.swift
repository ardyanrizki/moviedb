//
//  GenreInteractor.swift
//  movieapi_project
//
//  Created by Ardyan on 25/09/22.
//  
//

import Foundation

class GenreInteractor: PresenterToInteractorGenreProtocol {

    // MARK: Properties
    var presenter: InteractorToPresenterGenreProtocol?
    
    func fetchGenreList() {
        MovieService.shared.getGenreList(success: { [weak self] data in
            self?.presenter?.fetchGenreListDidSuccess(data: data.genres ?? [])
        }, failure: { [weak self] error in
            self?.presenter?.fetchGenreListDidFail(error: error)
        })
    }
}
