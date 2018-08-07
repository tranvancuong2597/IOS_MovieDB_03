//
//  FavoriteTableViewCell.swift
//  Movie
//
//  Created by TranCuong on 8/7/18.
//  Copyright © 2018 Tran Cuong. All rights reserved.
//

import UIKit
import Reusable

class FavoriteTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var nameMovieLabel: UILabel!
    @IBOutlet weak var descriptionMovieLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCell(movie: Movie?) {
        self.nameMovieLabel.text = movie?.title
         self.descriptionMovieLabel.text = movie?.overview
        guard let poster = movie?.posterPath else { return }
        let url = URL(string: URLs.posterImage + poster)
        self.movieImageView.sd_setImage(with: url, completed: nil)
    }
}
