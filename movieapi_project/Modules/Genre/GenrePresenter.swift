//
//  GenrePresenter.swift
//  movieapi_project
//
//  Created by Ardyan on 25/09/22.
//  
//

import Foundation

class GenrePresenter: ViewToPresenterGenreProtocol {
    
    // MARK: Properties
    var view: PresenterToViewGenreProtocol?
    var interactor: PresenterToInteractorGenreProtocol?
    var router: PresenterToRouterGenreProtocol?
    
    var genreList: [GenreModel] = []
    
    func viewDidLoad() {
        view?.setActivityIndicator(isLoading: true)
        interactor?.fetchGenreList()
    }
    
    func cellDidSelected(at indexPath: IndexPath) {
        router?.pushDiscoverMovies(on: view, by: genreList[indexPath.item])
    }
}

extension GenrePresenter: InteractorToPresenterGenreProtocol {
    
    func fetchGenreListDidSuccess(data: [GenreModel]) {
        DispatchQueue.main.async {
            self.view?.setActivityIndicator(isLoading: false)
            self.genreList = data
            self.view?.reloadTableView()
        }
    }
    
    func fetchGenreListDidFail(error: NSError) {
        DispatchQueue.main.async {
            self.view?.setActivityIndicator(isLoading: false)
            self.router?.presentAlert(title: StringResources.error, message: error.localizedDescription, from: self.view)
        }
    }
}
