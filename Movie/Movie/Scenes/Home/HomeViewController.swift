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
    var genres = [Genre]()
    var moviesList = [String : [Movie]]()
    private let homeRepository: HomeRepository = HomeRepositoryImpl(api: APIService.share)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(cellType: GenreTableViewCell.self)
        loadData()
    }
    
    func loadData() {
        homeRepository.getGenres { (resultGenres) in
            switch resultGenres {
            case .success(let genreRespone):
                guard let result = genreRespone?.genres else { return }
                for item in result {
                    guard let id = item.id else { return }
                    self.homeRepository.getMoviesList(id: id, completion: { (resultMoveList) in
                        switch resultMoveList {
                        case .success(let moviesListRespone):
                            guard let id = moviesListRespone?.id else { return }
                            guard let movies = moviesListRespone?.movies else { return }
                            self.moviesList[String(id)] = movies
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
        return  genres.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height / 2 - cellConstaintSize.heightTableCell
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: GenreTableViewCell.self) as GenreTableViewCell
        let item = genres[indexPath.row]
        guard let id = item.id, let name = item.name else {
            return UITableViewCell()
        }
        let idStr = String(id)
        let movies = moviesList[idStr]
        cell.updateCell(name: name, movies: movies)
        return cell
    }
}
