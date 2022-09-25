//
//  GenreContract.swift
//  movieapi_project
//
//  Created by Ardyan on 25/09/22.
//  
//

import Foundation


// MARK: View Output (Presenter -> View)
protocol PresenterToViewGenreProtocol {
   func reloadTableView()
    func setActivityIndicator(isLoading: Bool)
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterGenreProtocol {
    var view: PresenterToViewGenreProtocol? { get set }
    var interactor: PresenterToInteractorGenreProtocol? { get set }
    var router: PresenterToRouterGenreProtocol? { get set }
    var genreList: [GenreModel] { get }
    func viewDidLoad()
    func cellDidSelected(at indexPath: IndexPath)
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorGenreProtocol {
    var presenter: InteractorToPresenterGenreProtocol? { get set }
    func fetchGenreList()
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterGenreProtocol {
    func fetchGenreListDidSuccess(data: [GenreModel])
    func fetchGenreListDidFail(error: NSError)
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterGenreProtocol {
    func pushDiscoverMovies(on view: PresenterToViewGenreProtocol?, by genreId: GenreModel)
    func presentAlert(title: String, message: String, from view: PresenterToViewGenreProtocol?)
}
