//
//  MovieViewController.swift
//  movieapi_project
//
//  Created by Ardyan on 25/09/22.
//  
//

import UIKit
import Kingfisher

class MovieViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupCollectionView()
        title = presenter?.genre.name
    }

    // MARK: - Properties
    var presenter: ViewToPresenterMovieProtocol?
    
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MovieCollectionViewCell.nib(), forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
    }
    
}

extension MovieViewController: PresenterToViewMovieProtocol{
    func loadMovieList() {
        collectionView.reloadData()
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

extension MovieViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.movieList.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell, let movieData = presenter?.movieList[indexPath.item] else {
            return UICollectionViewCell()
        }
        cell.configure(movie: movieData)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.cellDidSelected(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width / 2) - 16
        let height = width * 1.5
        return .init(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .init(16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let movieList = presenter?.movieList else {
            return
        }
        if indexPath.item == movieList.count - 1 {
            presenter?.tableViewReachedEndCell()
        }
    }
    
}
