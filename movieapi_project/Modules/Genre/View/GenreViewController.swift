//
//  GenreViewController.swift
//  movieapi_project
//
//  Created by Ardyan on 25/09/22.
//  
//

import UIKit

class GenreViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupTable()
        navigationController?.navigationBar.topItem?.title = StringResources.movieGenre
    }

    // MARK: - Properties
    var presenter: ViewToPresenterGenreProtocol?
    
    private func setupTable() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}

extension GenreViewController: PresenterToViewGenreProtocol {
    
    func reloadTableView() {
        tableView.reloadData()
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

extension GenreViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.genreList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = presenter?.genreList[indexPath.item].name
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.cellDidSelected(at: indexPath)
    }
    
}
