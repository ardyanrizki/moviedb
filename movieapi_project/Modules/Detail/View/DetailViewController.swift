//
//  DetailViewController.swift
//  movieapi_project
//
//  Created by Ardyan on 25/09/22.
//  
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var watchButton: UIButton!
    @IBOutlet weak var reviewButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupView()
    }

    // MARK: - Properties
    var presenter: ViewToPresenterDetailProtocol?
    
    func setupView() {
        posterImage.contentMode = .scaleAspectFill
    }
    
    @IBAction func watchButtonDidPressed(_ sender: UIButton) {
        presenter?.watchButtonDidPressed()
    }
    
    @IBAction func reviewButtonDidPressed(_ sender: UIButton) {
        presenter?.reviewButtonDidPressed()
    }
    
}

extension DetailViewController: PresenterToViewDetailProtocol{
    
    func loadMovieDetail() {
        let movieData = presenter?.movieData
        navigationController?.navigationBar.topItem?.title = movieData?.title
        posterImage.kf.setImage(with: URL(string: "\(Constants.imageBaseUrl)\(movieData?.posterPath ?? "")"))
        titleLabel.text = movieData?.title
        descLabel.text = movieData?.overview
    }
    
    func setActivityIndicator(isLoading: Bool) {
        if isLoading {
            titleLabel.isHidden = true
            descLabel.isHidden = true
            watchButton.isEnabled = false
            reviewButton.isEnabled = false
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
        } else {
            titleLabel.isHidden = false
            descLabel.isHidden = false
            watchButton.isEnabled = true
            reviewButton.isEnabled = true
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
        }
    }
}
