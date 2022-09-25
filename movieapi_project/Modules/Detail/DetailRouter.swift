//
//  DetailRouter.swift
//  movieapi_project
//
//  Created by Ardyan on 25/09/22.
//  
//

import Foundation
import UIKit

class DetailRouter: PresenterToRouterDetailProtocol {
    
    // MARK: Static methods
    static func createModule(movieId: Int) -> UIViewController {
        
        let viewController = DetailViewController()
        
        let presenter: ViewToPresenterDetailProtocol & InteractorToPresenterDetailProtocol = DetailPresenter(id: movieId)
        
        viewController.presenter = presenter
        viewController.presenter?.router = DetailRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = DetailInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
    func pushVideo(on view: PresenterToViewDetailProtocol?, by movie: MovieDetailModel) {
        guard let viewController = view as? DetailViewController else {
            return
        }
        let videoViewController = VideoRouter.createModule(movie: movie)
        viewController.navigationController?.pushViewController(videoViewController, animated: true)
    }
    
    func pushReview(on view: PresenterToViewDetailProtocol?, by movieId: Int) {
        guard let viewController = view as? DetailViewController else {
            return
        }
        let reviewViewController = ReviewRouter.createModule(movieId: movieId)
        viewController.navigationController?.pushViewController(reviewViewController, animated: true)
    }
    
    func popController(from view: PresenterToViewDetailProtocol?) {
        guard let view = view as? DetailViewController else {
            return
        }
        view.navigationController?.popViewController(animated: true)
    }
    
    func presentAlert(title: String, message: String, from view: PresenterToViewDetailProtocol?) {
        guard let view = view as? DetailViewController else {
            return
        }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: StringResources.close, style: .cancel, handler: nil))
        view.present(alert, animated: true)
    }
    
}
