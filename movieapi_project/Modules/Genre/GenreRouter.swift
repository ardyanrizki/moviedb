//
//  GenreRouter.swift
//  movieapi_project
//
//  Created by Ardyan on 25/09/22.
//  
//

import Foundation
import UIKit

class GenreRouter: PresenterToRouterGenreProtocol {
    
    // MARK: Static methods
    static func createModule() -> UINavigationController {
        
        let viewController = GenreViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        let presenter: ViewToPresenterGenreProtocol & InteractorToPresenterGenreProtocol = GenrePresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = GenreRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = GenreInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return navigationController
    }
    
    func pushDiscoverMovies(on view: PresenterToViewGenreProtocol?, by genre: GenreModel) {
        guard let viewController = view as? GenreViewController else {
            return
        }
        let movieViewController = MovieRouter.createModule(genre: genre)
        viewController.navigationController?.pushViewController(movieViewController, animated: true)
    }
    
    func presentAlert(title: String, message: String, from view: PresenterToViewGenreProtocol?) {
        guard let view = view as? GenreViewController else {
            return
        }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: StringResources.close, style: .cancel, handler: nil))
        view.present(alert, animated: true)
    }
    
}
