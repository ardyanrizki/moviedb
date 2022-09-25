//
//  MovieContract.swift
//  movieapi_project
//
//  Created by Ardyan on 25/09/22.
//  
//

import Foundation


// MARK: View Output (Presenter -> View)
protocol PresenterToViewMovieProtocol {
    func loadMovieList()
    func setActivityIndicator(isLoading: Bool)
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterMovieProtocol {
    var view: PresenterToViewMovieProtocol? { get set }
    var interactor: PresenterToInteractorMovieProtocol? { get set }
    var router: PresenterToRouterMovieProtocol? { get set }
    var genre: GenreModel { get }
    var movieList: [MovieModel] { get }
    func viewDidLoad()
    func tableViewReachedEndCell()
    func cellDidSelected(at indexPath: IndexPath)
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorMovieProtocol {
    var presenter: InteractorToPresenterMovieProtocol? { get set }
    func fetchMovieList(by genreId: Int, page: Int)
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterMovieProtocol {
    func fetchMovieListDidSuccess(data: MovieResultModel)
    func fetchMovieListDidFail(error: NSError)
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterMovieProtocol {
    func pushMovieDetail(on view: PresenterToViewMovieProtocol?, by movieId: Int)
    func popController(from view: PresenterToViewMovieProtocol?)
    func presentAlert(title: String, message: String, from view: PresenterToViewMovieProtocol?)
}
