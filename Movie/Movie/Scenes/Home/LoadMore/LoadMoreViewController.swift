
//
//  LoadMoreViewController.swift
//  Movie
//
//  Created by Da on 8/2/18.
//  Copyright © 2018 Tran Cuong. All rights reserved.
//

import UIKit
import Reusable

class LoadMoreViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var backButton: UIButton!
    
    var movies = [Movie]()
    private struct Constant {
        static let spaceItem = CGFloat(0)
        static let spaceLine = CGFloat(0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.reloadData()
    }
    
    func setup() {
        collectionView.register(cellType: MovieCollectionViewCell.self)
        backButton.imageView?.contentMode = .scaleAspectFit
    }
    
    func reloadData(movies: [Movie]) {
        self.movies = movies
    }
    
    @IBAction func backHomeTappedButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension LoadMoreViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: MovieCollectionViewCell.self) as MovieCollectionViewCell
        cell.updateCell(movie: movies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width: (collectionView.frame.width) / 4 + 4 * cellConstaintSize.spaceCollectionCell , height: collectionView.frame.height / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constant.spaceItem
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constant.spaceLine
    }
}
