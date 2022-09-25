//
//  VideoRouter.swift
//  movieapi_project
//
//  Created by Ardyan on 25/09/22.
//  
//

import Foundation
import UIKit

class VideoRouter: PresenterToRouterVideoProtocol {
    
    // MARK: Static methods
    static func createModule(movie: MovieDetailModel) -> UIViewController {
        
        let viewController = VideoViewController()
        
        let presenter: ViewToPresenterVideoProtocol & InteractorToPresenterVideoProtocol = VideoPresenter(movie: movie)
        
        viewController.presenter = presenter
        viewController.presenter?.router = VideoRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = VideoInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
    func presentAlert(title: String, message: String, from view: PresenterToViewVideoProtocol?) {
            guard let view = view as? VideoViewController else {
                return
            }
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: StringResources.close, style: .cancel, handler: nil))
            view.present(alert, animated: true)
    }
    
}
