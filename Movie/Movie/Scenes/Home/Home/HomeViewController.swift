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
    // MARK: VARIABLES
    var genres: [Genre]?
    var moviesDic = [String : [Movie]]()
    private let homeRepository: HomeRepository = HomeRepositoryImpl(api: APIService.share)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showHud("Loading")
        tableView.register(cellType: GenreTableViewCell.self)
        loadData()
    }
    
    func loadData() {
        homeRepository.getGenres { (resultGenres) in
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
            self.hideHUD()  
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
        return tableView.bounds.height / 2 - cellConstaintSize.heightTableCell
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

extension HomeViewController: GenreTableViewDelegate {
    func pushMovieDetail(movie: Movie) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: IdentifierScreen.movieDetail) as? MovieDetailViewController else {
            return
        }
        vc.movie = movie
        self.present(vc, animated: true, completion: nil)
    }
    
    func loadmoreAction(movies: [Movie]) {
        let storyboad = UIStoryboard(name: Storyboard.home, bundle: nil)
        guard let vc = storyboad.instantiateViewController(withIdentifier: IdentifierScreen.loadMore) as? LoadMoreViewController else {
            return
        }
        vc.showHud("Loading")
        vc.reloadData(movies: movies)
        vc.hideHUD()
        self.present(vc, animated: true, completion: nil)
    }
}
