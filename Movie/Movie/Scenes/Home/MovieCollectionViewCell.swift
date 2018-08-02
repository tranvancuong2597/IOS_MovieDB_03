//
//  MovieCollectionViewCell.swift
//  Movie
//
//  Created by Da on 7/31/18.
//  Copyright © 2018 Tran Cuong. All rights reserved.
//

import UIKit
import SDWebImage
import Reusable
import Cosmos

class MovieCollectionViewCell: UICollectionViewCell, NibReusable {
    
    // MARK: OUTLET
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var cosmosView: CosmosView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    // MARK: VARIABLES
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateCell(movie: Movie?) {
        self.titleLabel.text = movie?.title
        guard let poster = movie?.posterPath else { return }
        let url = URL(string: URLs.Poster_image + poster)
        self.posterImageView.sd_setImage(with: url, completed: nil)
    }
}
