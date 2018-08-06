//
//  TopFilmViewController.swift
//  Movie
//
//  Created by TranCuong on 8/1/18.
//  Copyright © 2018 Tran Cuong. All rights reserved.
//

import UIKit
import Reusable

class TopFilmViewController: UIViewController {
    
    @IBOutlet private weak var topFilmTableView: UITableView!
    @IBOutlet private weak var nameScreen: UILabel!
    let minusHeightTable = CGFloat(40)
    var arrFilm = [[Movie]]()
    var topRateFilm = [Movie]()
    var popularFilm = [Movie]()
    var upcommingFilm = [Movie]()
    private let movieRepository: MovieRepository = MovieRepositoryImpl(api: APIService.share)
    
    enum TypeFilm: Int {
        case topRate
        case popular
        case upcoming
        case all
        
        var getMessage : String {
            switch self {
            case .topRate:
                return "Top Rate"
            case .popular:
                return "Popular"
            case .upcoming:
                return "Upcoming"
            case .all:
                return ""
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setTableView()
       
    }
    override func viewWillAppear(_ animated: Bool) {
         loadData()
    }
    func setTableView() {
        self.topFilmTableView.backgroundColor = UIColor.black
        topFilmTableView.delegate = self
        topFilmTableView.dataSource = self
        topFilmTableView.register(cellType: TopFilmTableViewCell.self)
    }
    
    func setupUI() {
        let lineView = UIView()
        lineView.backgroundColor = ColorConstant.lineColor
        lineView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lineView)
        
        lineView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        lineView.topAnchor.constraint(equalTo: nameScreen.bottomAnchor).isActive = true
        lineView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    func loadData() {
        loadDataTopRate()
        loadDataPopular()
        loadDataUpcoming()
    }
    
    func loadDataTopRate() {
        self.movieRepository.getTopMoviesList(completion: { [weak self] (resultList) in
            guard let `self` = self else { return }
            switch resultList {
            case .success(let moviesTopListResponse):
                guard let movies = moviesTopListResponse?.movies else { return }
                self.topRateFilm = movies
                print(self.topRateFilm.count)
                self.arrFilm.append(self.topRateFilm)
                DispatchQueue.main.async {
                    self.topFilmTableView.reloadData()
                }
            case .failure( _):
                print("Error")
            }
        })
    }
    
    func loadDataPopular() {
        movieRepository.getPopularMoviesList(completion: { [weak self] (resultList) in
            guard let `self` = self else { return }
            switch resultList {
            case .success(let moviesPopularListResponse):
                guard let movies = moviesPopularListResponse?.movies else { return }
                self.popularFilm = movies
                self.arrFilm.append(self.popularFilm)
                DispatchQueue.main.async {
                    self.topFilmTableView.reloadData()
                }
            case .failure( _):
                print("Error")
            }
        })
    }
    
    func loadDataUpcoming() {
        self.movieRepository.getUpcomingMoviesList(completion: { [weak self] (resultList) in
            guard let `self` = self else { return }
            switch resultList {
            case .success(let moviesUpcomingListResponse):
                guard let movies = moviesUpcomingListResponse?.movies else { return }
                self.upcommingFilm = movies
                self.arrFilm.append(self.upcommingFilm)
                DispatchQueue.main.async {
                    self.topFilmTableView.reloadData()
                }
            case .failure( _):
                print("Error")
            }
        })
    }
}

extension TopFilmViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TypeFilm.all.rawValue
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height / 2 - self.minusHeightTable
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = topFilmTableView.dequeueReusableCell(for: indexPath, cellType: TopFilmTableViewCell.self) as TopFilmTableViewCell
        guard let type = TypeFilm(rawValue: indexPath.row) else {
            return UITableViewCell()
        }
        if arrFilm.count >= 3 {
            cell.updateCell(movies: arrFilm[indexPath.row], namelbl: type.getMessage)
        }
        return cell
    }
}
