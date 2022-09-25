//
//  VideoPresenter.swift
//  movieapi_project
//
//  Created by Ardyan on 25/09/22.
//  
//

import Foundation

class VideoPresenter: ViewToPresenterVideoProtocol {

    // MARK: Properties
    var view: PresenterToViewVideoProtocol?
    var interactor: PresenterToInteractorVideoProtocol?
    var router: PresenterToRouterVideoProtocol?
    
    let movie: MovieDetailModel
    var videoList: [VideoModel] = [] {
        didSet {
            videoList = videoList.reversed()
        }
    }
    var selectedVideo: VideoModel? {
        didSet {
            view?.playVideo()
        }
    }
    
    init(movie: MovieDetailModel) {
        self.movie = movie
    }
    
    func viewDidLoad() {
        guard let movieId = movie.id else {
            return
        }
        view?.setActivityIndicator(isLoading: true)
        interactor?.fetchVideoList(with: movieId)
    }
    
    func cellDidPressed(at indexPath: IndexPath) {
        selectedVideo = videoList[indexPath.item]
    }
    
    private func filterYTVideos(_ videos: [VideoModel]) -> [VideoModel] {
        return videos.filter({
            $0.site?.lowercased() == "youtube"
        })
    }
    
}

extension VideoPresenter: InteractorToPresenterVideoProtocol {
    
    func fetchVideoListDidSuccess(data: [VideoModel]) {
        DispatchQueue.main.async {
            self.view?.setActivityIndicator(isLoading: false)
            self.videoList = self.filterYTVideos(data)
            if self.videoList.count > 0 {
                self.selectedVideo = self.videoList[0]
            }
            self.view?.reloadTableView()
        }
    }
    
    func fetchVideoListDidFail(error: NSError) {
        DispatchQueue.main.async {
            self.view?.setActivityIndicator(isLoading: false)
            self.router?.presentAlert(title: StringResources.error, message: error.localizedDescription, from: self.view)
        }
    }
    
}
