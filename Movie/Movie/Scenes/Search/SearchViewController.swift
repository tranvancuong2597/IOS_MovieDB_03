//
//  SreachViewController.swift
//  Movie
//
//  Created by Da on 7/31/18.
//  Copyright © 2018 Tran Cuong. All rights reserved.
//

import UIKit
import Reusable

class SearchViewController: UIViewController, UISearchBarDelegate, NibReusable {

    @IBOutlet weak var nameScreen: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    var movies = [Movie]()
    var currentMovieArray = [Movie]()
    var searchList = [String]()
    private let movieRepository: MovieRepository = MovieRepositoryImpl(api: APIService.share)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupSearchBar()
        setup()
    }
    
    func setupUI() {
        let lineView = UIView()
        lineView.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lineView)
        
        lineView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        lineView.topAnchor.constraint(equalTo: nameScreen.bottomAnchor).isActive = true
        lineView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    func setup() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(cellType: TopFilmCollectionViewCell.self)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = searchBar.text else {
            movies.removeAll()
            collectionView.reloadData()
            return
        }
        movies.removeAll()
        loadData(query: text)
    }

    private func loadData(query: String) {
        self.movieRepository.getSearchMoviesList(query: query, page: 1) { resultList in
            switch resultList {
            case .success(let moviesSearchListResponse):
                print("aaaa")
                self.setData(moviesSearchByQueryResponse: moviesSearchListResponse)
            case .failure(let error):
                print(error?.errorMessage ?? "")
            }
        }
    }
    
    func setupSearchBar() {
        searchBar.delegate = self
    }
    
    func setData(moviesSearchByQueryResponse: SearchMoviesResponse?) {
        guard let searchMoviesData = moviesSearchByQueryResponse?.movies else {
            return
        }
        self.movies = searchMoviesData
        for item in searchMoviesData {
            self.searchList.append(item.title ?? "")
        }
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            print("Collection")
        }
    }

}

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: TopFilmCollectionViewCell.self)
        if let cell = cell as? TopFilmCollectionViewCell {
            cell.updateCell(movie: movies[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width) / 4 + 4 * 8, height: collectionView.frame.height / 3)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
