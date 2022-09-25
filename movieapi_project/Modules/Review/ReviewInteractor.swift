//
//  ReviewInteractor.swift
//  movieapi_project
//
//  Created by Ardyan on 25/09/22.
//  
//

import Foundation

class ReviewInteractor: PresenterToInteractorReviewProtocol {

    // MARK: Properties
    var presenter: InteractorToPresenterReviewProtocol?
    
    func fetchReviewList(by movieId: Int, page: Int) {
        MovieService.shared.getReviewList(by: movieId, page: page, success: { [weak self] data in
            self?.presenter?.fetchReviewListDidSuccess(data: data)
        }, failure: { [weak self] error in
            self?.presenter?.fetchReviewListDidFail(error: error)
        })
    }
}
