//
//  VideoViewController.swift
//  movieapi_project
//
//  Created by Ardyan on 25/09/22.
//  
//

import UIKit
import youtube_ios_player_helper

class VideoViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var playerView: YTPlayerView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupTableView()
    }

    // MARK: - Properties
    var presenter: ViewToPresenterVideoProtocol?
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}

extension VideoViewController: PresenterToViewVideoProtocol{
    
    // TODO: Implement View Output Methods
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func playVideo() {
        guard let video = presenter?.selectedVideo, let key = video.key else {
            return
        }
        titleLabel.text = video.name ?? ""
        playerView.load(withVideoId: key)
        playerView.playVideo()
    }
    
    func setActivityIndicator(isLoading: Bool) {
        if isLoading {
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
        } else {
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
        }
    }
    
}

extension VideoViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.videoList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        let video = presenter?.videoList[indexPath.item]
        content.text = video?.name
        cell.contentConfiguration = content
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.cellDidPressed(at: indexPath)
    }
    
}


