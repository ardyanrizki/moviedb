//
//  VideoInteractor.swift
//  movieapi_project
//
//  Created by Ardyan on 25/09/22.
//  
//

import Foundation

class VideoInteractor: PresenterToInteractorVideoProtocol {

    // MARK: Properties
    var presenter: InteractorToPresenterVideoProtocol?
    
    func fetchVideoList(with movieId: Int) {
        MovieService.shared.getVideoList(by: movieId, success: { [weak self] data in
            self?.presenter?.fetchVideoListDidSuccess(data: data.results ?? [])
        }, failure: { [weak self] error in
            self?.presenter?.fetchVideoListDidFail(error: error)
        })
    }
    
}
