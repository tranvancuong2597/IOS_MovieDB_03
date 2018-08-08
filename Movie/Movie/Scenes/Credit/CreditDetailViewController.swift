//
//  CreditDetailViewController.swift
//  Movie
//
//  Created by Da on 8/6/18.
//  Copyright © 2018 Tran Cuong. All rights reserved.
//

import UIKit
import Reusable

class CreditDetailViewController: UIViewController, NibReusable {
    //MAKR: OUTLET
    @IBOutlet private weak var titleView: UIView!
    @IBOutlet private weak var infoView: UIView!
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var genderLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var placeBirthLabel: UILabel!
    @IBOutlet private weak var knowLedgeLabel: UILabel!
    @IBOutlet private weak var biographyLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    
    //MARK: VARIABLE
    var credit: Credit?
    var movies = [Movie]()
    
    private struct Constant {
        static let placeBirthString = "Place birth: "
        static let dateBirthString = "Date: "
        static let womanString = "Gender: Woman"
        static let manString = "Gender: Man"
        static let heighCellRatioSize: CGFloat = 1 / 3
        static let widthBorderSize: CGFloat = 1
        static let whiteColor = UIColor.white.cgColor
        static let loadString = "Loading ... "
    }
    
    
    private let creditDetailRepository: CreditDetailRepository = CreditDetailRepositoryImpl(api: APIService.share)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        self.showHud(Constant.loadString)
        loadData()
        loadWithApi()
        self.hideHUD()
    }
    
    private func setup() {
        tableView.register(cellType: CreditDetailTableViewCell.self)
        setupUILine(view: titleView)
    }
    
    private func loadData(){
        guard let name = credit?.name,
            let gender = credit?.gender,
            let poster = credit?.profilePath,
            let url = URL(string: URLs.posterImage + poster) else {
                return
        }
        avatarImageView.sd_setImage(with: url, completed: nil)
        nameLabel.text = name
        genderLabel.text = gender == 1 ? Constant.womanString : Constant.manString
    }
    
    private func loadWithApi() {
        showHud(Constant.loadString)
        guard let id = credit?.id else { return }
        creditDetailRepository.getDetailPerson(id: id) { [weak self] (resultPerson) in
            guard let `self` = self else { return }
            self.hideHUD()
            switch resultPerson {
            case .success(let personRespone):
                guard let biography = personRespone?.biography,
                    let knownForDepartment = personRespone?.knownForDepartment,
                    let placeOfBirth = personRespone?.placeOfBirth,
                    let birthday = personRespone?.birthday else { return }
                self.biographyLabel.text = biography
                self.knowLedgeLabel.text = knownForDepartment
                self.placeBirthLabel.text = Constant.placeBirthString + placeOfBirth
                self.dateLabel.text = Constant.dateBirthString + birthday
            case .failure( _):
                print("ERROR CREDIT")
            }
        }
        creditDetailRepository.getMovies(id: id) { [weak self] (resultCredits) in
            guard let `self` = self else { return }   
            switch resultCredits {
            case .success(let creditRespone):
                guard let movies = creditRespone?.movies
                    else { return }
                self.movies = movies
                self.tableView.reloadData()
            case .failure( _):
                print("ERROR CREDIT")
            }
        }
    }
    
    @IBAction func backTappedButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension CreditDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: CreditDetailTableViewCell.self) as CreditDetailTableViewCell
        let movie = movies[indexPath.row]
        cell.updateCell(movie: movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height * Constant.heighCellRatioSize
    }
}
