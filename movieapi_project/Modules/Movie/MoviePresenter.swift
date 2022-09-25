//
//  MoviePresenter.swift
//  movieapi_project
//
//  Created by Ardyan on 25/09/22.
//  
//

import Foundation

class MoviePresenter: ViewToPresenterMovieProtocol {

    // MARK: Properties
    var view: PresenterToViewMovieProtocol?
    var interactor: PresenterToInteractorMovieProtocol?
    var router: PresenterToRouterMovieProtocol?
    
    var genre: GenreModel
    var movieList: [MovieModel] = []
    var loadedPageNumber: Int = 1
    var totalPages: Int = 0
    
    init(genre: GenreModel) {
        self.genre = genre
    }
    
    func viewDidLoad() {
        guard let genreId = genre.id else {
            return
        }
        view?.setActivityIndicator(isLoading: true)
        interactor?.fetchMovieList(by: genreId, page: loadedPageNumber)
    }
    
    func tableViewReachedEndCell() {
        if totalPages > loadedPageNumber {
            guard let genreId = genre.id else {
                return
            }
            view?.setActivityIndicator(isLoading: true)
            interactor?.fetchMovieList(by: genreId, page: loadedPageNumber + 1)
        }
    }
    
    func cellDidSelected(at indexPath: IndexPath) {
        guard let movieId = movieList[indexPath.item].id else {
            return
        }
        router?.pushMovieDetail(on: view, by: movieId)
    }
}

extension MoviePresenter: InteractorToPresenterMovieProtocol {
    
    func fetchMovieListDidSuccess(data: MovieResultModel) {
        DispatchQueue.main.async {
            self.movieList.append(contentsOf: data.results ?? [])
            if let page = data.page, let totalPages = data.totalPages {
                self.loadedPageNumber = page
                self.totalPages = totalPages
            }
            self.view?.setActivityIndicator(isLoading: false)
            self.view?.loadMovieList()
        }
    }
    
    func fetchMovieListDidFail(error: NSError) {
        DispatchQueue.main.async {
            self.view?.setActivityIndicator(isLoading: false)
            self.router?.presentAlert(title: StringResources.error, message: error.localizedDescription, from: self.view)
        }
    }
    
}
