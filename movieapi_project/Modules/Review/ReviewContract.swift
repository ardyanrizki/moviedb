//
//  ReviewContract.swift
//  movieapi_project
//
//  Created by Ardyan on 25/09/22.
//  
//

import Foundation


// MARK: View Output (Presenter -> View)
protocol PresenterToViewReviewProtocol {
   func reloadTableView()
    func setActivityIndicator(isLoading: Bool)
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterReviewProtocol {
    var view: PresenterToViewReviewProtocol? { get set }
    var interactor: PresenterToInteractorReviewProtocol? { get set }
    var router: PresenterToRouterReviewProtocol? { get set }
    var reviewList: [ReviewModel] { get }
    func viewDidLoad()
    func tableViewReachedEndCell()
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorReviewProtocol {
    var presenter: InteractorToPresenterReviewProtocol? { get set }
    func fetchReviewList(by movieId: Int, page: Int)
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterReviewProtocol {
    func fetchReviewListDidSuccess(data: ReviewResultModel)
    func fetchReviewListDidFail(error: NSError)
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterReviewProtocol {
    func presentAlert(title: String, message: String, from view: PresenterToViewReviewProtocol?)
}
