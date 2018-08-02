//
//  GenreTableViewCell.swift
//  Movie
//
//  Created by Da on 7/31/18.
//  Copyright © 2018 Tran Cuong. All rights reserved.
//

import UIKit
import Reusable

protocol GenreTableViewDelegate: class {
    func loadmoreAction(movies: [Movie])
}

class GenreTableViewCell: UITableViewCell, NibReusable {
    
    // MARK: OUTLET
    @IBOutlet private weak var name_Genre_Label: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var loadMoreButton: UIButton!
    
    // MARK: VARIABLES
    var movies = [Movie]()
    weak var delegate: GenreTableViewDelegate?
    private let moviesListRepository: MovieRepository = MovieRepositoryImpl(api: APIService.share)
    
    func updateCell(name: String, movies: [Movie]?) {
        name_Genre_Label.text = name
        guard let movies = movies else {
            return
        }
        self.movies = movies
        self.collectionView.reloadData()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    @IBAction func loadmoreActionButton(_ sender: Any) {
        delegate?.loadmoreAction(movies: movies)
    }
    
    func setup() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(cellType: MovieCollectionViewCell.self)
    }
}

extension GenreTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: MovieCollectionViewCell.self)
        cell.updateCell(movie: movies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width) / 4 + 5 * cellConstaintSize.spaceCollectionCell , height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
