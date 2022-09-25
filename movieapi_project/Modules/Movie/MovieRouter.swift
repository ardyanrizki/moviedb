//
//  MovieRouter.swift
//  movieapi_project
//
//  Created by Ardyan on 25/09/22.
//  
//

import Foundation
import UIKit

class MovieRouter: PresenterToRouterMovieProtocol {
    
    // MARK: Static methods
    static func createModule(genre: GenreModel) -> UIViewController {
        
        let viewController = MovieViewController()
        
        let presenter: ViewToPresenterMovieProtocol & InteractorToPresenterMovieProtocol = MoviePresenter(genre: genre)
        
        viewController.presenter = presenter
        viewController.presenter?.router = MovieRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = MovieInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
    func pushMovieDetail(on view: PresenterToViewMovieProtocol?, by movieId: Int) {
        guard let viewController = view as? MovieViewController else {
            return
        }
        let detailViewController = DetailRouter.createModule(movieId: movieId)
        viewController.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func popController(from view: PresenterToViewMovieProtocol?) {
        guard let view = view as? MovieViewController else {
            return
        }
        view.navigationController?.popViewController(animated: true)
    }
    
    func presentAlert(title: String, message: String, from view: PresenterToViewMovieProtocol?) {
        guard let view = view as? MovieViewController else {
            return
        }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: StringResources.close, style: .cancel, handler: nil))
        view.present(alert, animated: true)
    }
}
