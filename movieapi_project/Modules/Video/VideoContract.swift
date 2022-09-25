//
//  VideoContract.swift
//  movieapi_project
//
//  Created by Ardyan on 25/09/22.
//  
//

import Foundation


// MARK: View Output (Presenter -> View)
protocol PresenterToViewVideoProtocol {
    func reloadTableView()
    func playVideo()
    func setActivityIndicator(isLoading: Bool)
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterVideoProtocol {
    
    var view: PresenterToViewVideoProtocol? { get set }
    var interactor: PresenterToInteractorVideoProtocol? { get set }
    var router: PresenterToRouterVideoProtocol? { get set }
    var videoList: [VideoModel] { get }
    var selectedVideo: VideoModel? { get }
    func viewDidLoad()
    func cellDidPressed(at indexPath: IndexPath)
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorVideoProtocol {
    var presenter: InteractorToPresenterVideoProtocol? { get set }
    func fetchVideoList(with movieId: Int)
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterVideoProtocol {
    func fetchVideoListDidSuccess(data: [VideoModel])
    func fetchVideoListDidFail(error: NSError)
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterVideoProtocol {
    func presentAlert(title: String, message: String, from view: PresenterToViewVideoProtocol?)
}
