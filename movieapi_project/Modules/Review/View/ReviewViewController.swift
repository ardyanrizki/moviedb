//
//  ReviewViewController.swift
//  movieapi_project
//
//  Created by Ardyan on 25/09/22.
//  
//

import UIKit

class ReviewViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupTable()
        title = StringResources.review
    }

    // MARK: - Properties
    var presenter: ViewToPresenterReviewProtocol?
    
    private func setupTable() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}

extension ReviewViewController: PresenterToViewReviewProtocol {
    
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

extension ReviewViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let rows = presenter?.reviewList.count, rows > 0 {
            return rows
        }
        if activityIndicator.isHidden {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        if let rows = presenter?.reviewList.count, rows > 0 {
            let reviewData = presenter?.reviewList[indexPath.item]
            content.text = reviewData?.content
            content.textProperties.font = .systemFont(ofSize: 14)
            content.textProperties.color = .darkGray
            content.secondaryText = reviewData?.author
            content.secondaryTextProperties.font = .systemFont(ofSize: 16, weight: .bold)
            content.textToSecondaryTextVerticalPadding = 8.0
        } else {
            content.text = StringResources.noResult
            content.textProperties.alignment = .center
        }
        cell.contentConfiguration = content
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let reviewList = presenter?.reviewList else {
            return
        }
        if indexPath.item == reviewList.count - 1 {
            presenter?.tableViewReachedEndCell()
        }
    }
    
}
