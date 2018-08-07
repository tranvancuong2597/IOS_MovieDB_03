//
//  LibraryViewController.swift
//  Movie
//
//  Created by Da on 7/31/18.
//  Copyright © 2018 Tran Cuong. All rights reserved.
//

import UIKit
import Reusable

class LibraryViewController: UIViewController, NibReusable {
    var favoriteListMovies = [Movie]()
    @IBOutlet weak var nameScreen: UILabel!
    @IBOutlet weak var favoriteTableView: UITableView!
    let minusHeightTable = CGFloat(40)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setup()
        getData()
        print(favoriteListMovies)
    }
    
    private func setupUI() {
        let lineView = UIView()
        lineView.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lineView)
        
        lineView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        lineView.topAnchor.constraint(equalTo: nameScreen.bottomAnchor).isActive = true
        lineView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    private func setup() {
        self.favoriteTableView.delegate = self
        self.favoriteTableView.dataSource = self
        self.favoriteTableView.register(cellType: FavoriteTableViewCell.self)
        
    }
    
    private func getData() {
        favoriteListMovies = HandlingMoviesDatabase.fetchMovie()
        favoriteTableView.reloadData()
    }
}

extension LibraryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteListMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FavoriteTableViewCell = favoriteTableView.dequeueReusableCell(for: indexPath)
        if let cell = cell as? FavoriteTableViewCell {
            cell.setupCell(movie: favoriteListMovies[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height / 3 - self.minusHeightTable
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            if HandlingMoviesDatabase.deteleMovie(movie: favoriteListMovies[indexPath.row]) {
                self.favoriteListMovies.remove(at: indexPath.row)
                self.favoriteTableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
    }
    
}
