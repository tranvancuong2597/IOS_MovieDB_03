//
//  TopFilmCollectionViewCell.swift
//  Movie
//
//  Created by TranCuong on 8/1/18.
//  Copyright © 2018 Tran Cuong. All rights reserved.
//

import UIKit
import SDWebImage
import Reusable
import Cosmos

class TopFilmCollectionViewCell: UICollectionViewCell, NibReusable {
    
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var starView: CosmosView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    var movie: Movie?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateCell(movie: Movie?) {
        self.movie = movie
        self.titleLabel.text = movie?.title
        guard let poster = movie?.posterPath else { return }
        let url = URL(string: URLs.posterImage + poster)
        self.posterImageView.sd_setImage(with: url, completed: nil)
    }
}
