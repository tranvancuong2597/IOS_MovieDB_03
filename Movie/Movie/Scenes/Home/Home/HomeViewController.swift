//
//  HomeViewController.swift
//  Movie
//
//  Created by Da on 7/31/18.
//  Copyright © 2018 Tran Cuong. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    // MARK: OUTLET
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var titleScreenLabel: UILabel!
    @IBOutlet private weak var titleView: UIView!
    
    // MARK: VARIABLES
    var genres: [Genre]?
    var moviesDic = [String : [Movie]]()
    private let homeRepository: HomeRepository = HomeRepositoryImpl(api: APIService.share)
    
    private struct Constaint {
        static let spaceCollectionCell = CGFloat(8)
        static let heightTableCell = CGFloat(24)
        static let spaceItem = CGFloat(0)
        static let spaceLine = CGFloat(0)
        static let ratio: CGFloat = 1 / 2
        static let loadingStr = "Loading ..."
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUILine(view: titleView)
        tableView.register(cellType: GenreTableViewCell.self)
        loadData()
    }

    func loadData() {
        showHud(Constaint.loadingStr)
        homeRepository.getGenres { [weak self] (resultGenres) in
            guard let `self` = self else { return }
            self.hideHUD()
            switch resultGenres {
            case .success(let genreRespone):
                guard let result = genreRespone?.genres else { return }
                for item in result {
                    self.homeRepository.getMovies(id: item.id, completion: { (resultMoveList) in
                        switch resultMoveList {
                        case .success(let moviesListRespone):
                            guard let id = moviesListRespone?.id else { return }
                            guard let movies = moviesListRespone?.movies else { return }
                            self.moviesDic[String(id)] = movies
                            self.tableView.reloadData()
                        case .failure( _):
                            print("ERROR MOVIESLIST")
                        }
                    })
                }
                self.genres = result
            case .failure( _):
                print("ERROR GENRES")
            }
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = genres?.count else {
            return 0
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height * Constaint.ratio - Constaint.heightTableCell
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: GenreTableViewCell.self) as GenreTableViewCell
        guard let item = genres?[indexPath.row],
            let name = item.name else {
                return UITableViewCell()
        }
        let idStr = String(item.id)
        let movies = moviesDic[idStr]
        cell.updateCell(name: name, movies: movies)
        cell.delegate = self
        return cell
    }
}

extension HomeViewController: tableViewDelegate {
    func pushMovieDetail(movie: Movie) {
        let vc = MovieDetailViewController.instantiate()
        vc.movie = movie
        self.present(vc, animated: true, completion: nil)
    }
    
    func loadmoreAction(movies: [Movie]) {
        let vc = LoadMoreViewController.instantiate()
        vc.reloadData(movies: movies)
        self.present(vc, animated: true, completion: nil)
    }
}
