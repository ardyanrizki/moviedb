//
//  DetailPresenter.swift
//  movieapi_project
//
//  Created by Ardyan on 25/09/22.
//  
//

import Foundation

class DetailPresenter: ViewToPresenterDetailProtocol {

    // MARK: Properties
    var view: PresenterToViewDetailProtocol?
    var interactor: PresenterToInteractorDetailProtocol?
    var router: PresenterToRouterDetailProtocol?
    
    var id: Int
    var movieData: MovieDetailModel?
    
    init(id: Int) {
        self.id = id
    }
    
    func viewDidLoad() {
        view?.setActivityIndicator(isLoading: true)
        interactor?.fetchMovieDetail(with: id)
    }
    
    func reviewButtonDidPressed() {
        router?.pushReview(on: view, by: id)
    }
    
    func watchButtonDidPressed() {
        guard let movieData else {
            return
        }
        router?.pushVideo(on: view, by: movieData)
    }
}

extension DetailPresenter: InteractorToPresenterDetailProtocol {
    
    func fetchMovieDetailDidSuccess(data: MovieDetailModel) {
        DispatchQueue.main.async {
            self.movieData = data
            self.view?.setActivityIndicator(isLoading: false)
            self.view?.loadMovieDetail()
        }
    }
    
    func fetchMovieDetailDidFail(error: NSError) {
        DispatchQueue.main.async {
            self.view?.setActivityIndicator(isLoading: false)
            self.router?.presentAlert(title: StringResources.error, message: error.localizedDescription, from: self.view)
        }
    }
    
}
