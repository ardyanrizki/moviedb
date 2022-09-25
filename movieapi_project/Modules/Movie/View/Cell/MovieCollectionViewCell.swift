//
//  MovieCollectionViewCell.swift
//  movieapi_project
//
//  Created by Ardyan on 25/09/22.
//

import UIKit
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titlelabel: UILabel!
    @IBOutlet weak var overlay: UIView!
    
    static let identifier = "MovieCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        posterImageView.contentMode = .scaleAspectFill
        overlay.applyGradient(top: .clear, bottom: .secondaryLabel, locationTop: 0.2, locationBottom: 0.9)
    }
    
    func configure(movie: MovieModel) {
        posterImageView.kf.setImage(with: URL(string: "\(Constants.imageBaseUrl)\(movie.posterPath ?? "")"))
        titlelabel.text = movie.title
    }

}
