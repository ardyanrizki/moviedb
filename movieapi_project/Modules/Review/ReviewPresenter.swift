//
//  ReviewPresenter.swift
//  movieapi_project
//
//  Created by Ardyan on 25/09/22.
//  
//

import Foundation

class ReviewPresenter: ViewToPresenterReviewProtocol {

    // MARK: Properties
    var view: PresenterToViewReviewProtocol?
    var interactor: PresenterToInteractorReviewProtocol?
    var router: PresenterToRouterReviewProtocol?
    
    let movieId: Int
    var reviewList: [ReviewModel] = []
    var loadedPageNumber: Int = 1
    var totalPages: Int = 1
    
    init(movieId: Int) {
        self.movieId = movieId
    }
    
    func viewDidLoad() {
        view?.setActivityIndicator(isLoading: true)
        interactor?.fetchReviewList(by: movieId, page: loadedPageNumber)
    }
    
    func tableViewReachedEndCell() {
        if totalPages > loadedPageNumber {
            view?.setActivityIndicator(isLoading: true)
            interactor?.fetchReviewList(by: movieId, page: loadedPageNumber + 1)
        }
    }
}

extension ReviewPresenter: InteractorToPresenterReviewProtocol {
    
    func fetchReviewListDidSuccess(data: ReviewResultModel) {
        DispatchQueue.main.async {
            self.reviewList.append(contentsOf: data.results ?? [])
            if let page = data.page, let totalPages = data.totalPages {
                self.loadedPageNumber = page
                self.totalPages = totalPages
            }
            self.view?.setActivityIndicator(isLoading: false)
            self.view?.reloadTableView()
        }
    }
    
    func fetchReviewListDidFail(error: NSError) {
        DispatchQueue.main.async {
            self.view?.setActivityIndicator(isLoading: false)
            self.router?.presentAlert(title: StringResources.error, message: error.localizedDescription, from: self.view)
        }
    }
    
}
