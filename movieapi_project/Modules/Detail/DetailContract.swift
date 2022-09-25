//
//  DetailContract.swift
//  movieapi_project
//
//  Created by Ardyan on 25/09/22.
//  
//

import Foundation


// MARK: View Output (Presenter -> View)
protocol PresenterToViewDetailProtocol {
    func loadMovieDetail()
    func setActivityIndicator(isLoading: Bool)
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterDetailProtocol {
    var view: PresenterToViewDetailProtocol? { get set }
    var interactor: PresenterToInteractorDetailProtocol? { get set }
    var router: PresenterToRouterDetailProtocol? { get set }
    var movieData: MovieDetailModel? { get }
    func viewDidLoad()
    func reviewButtonDidPressed()
    func watchButtonDidPressed()
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorDetailProtocol {
    var presenter: InteractorToPresenterDetailProtocol? { get set }
    func fetchMovieDetail(with movieId: Int)
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterDetailProtocol {
    func fetchMovieDetailDidSuccess(data: MovieDetailModel)
    func fetchMovieDetailDidFail(error: NSError)
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterDetailProtocol {
    func pushReview(on view: PresenterToViewDetailProtocol?, by movieId: Int)
    func pushVideo(on view: PresenterToViewDetailProtocol?, by movie: MovieDetailModel)
    func presentAlert(title: String, message: String, from view: PresenterToViewDetailProtocol?)
}
