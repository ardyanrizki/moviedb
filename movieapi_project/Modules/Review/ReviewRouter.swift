//
//  ReviewRouter.swift
//  movieapi_project
//
//  Created by Ardyan on 25/09/22.
//  
//

import Foundation
import UIKit

class ReviewRouter: PresenterToRouterReviewProtocol {
    
    // MARK: Static methods
    static func createModule(movieId: Int) -> UIViewController {
        
        let viewController = ReviewViewController()
        
        let presenter: ViewToPresenterReviewProtocol & InteractorToPresenterReviewProtocol = ReviewPresenter(movieId: movieId)
        
        viewController.presenter = presenter
        viewController.presenter?.router = ReviewRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = ReviewInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
    func popController(from view: PresenterToViewReviewProtocol?) {
        guard let view = view as? ReviewViewController else {
            return
        }
        view.navigationController?.popViewController(animated: true)
    }
    
    func presentAlert(title: String, message: String, from view: PresenterToViewReviewProtocol?) {
        guard let view = view as? ReviewViewController else {
            return
        }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: StringResources.close, style: .cancel, handler: nil))
        view.present(alert, animated: true)
    }
    
}
