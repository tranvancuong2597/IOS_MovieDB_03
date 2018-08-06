//
//  MainViewController.swift
//  Movie
//
//  Created by Da on 7/31/18.
//  Copyright © 2018 Tran Cuong. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    var homeViewController = UIViewController()
    var topMovieViewController = UIViewController()
    var libraryViewController = UIViewController()
    var searchViewController = UIViewController()
    var feedbackViewController = UIViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showHud("Loading")
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        homeViewController = setupViewController(name_storyboard: Storyboard.home, id: Storyboard_id.home)
        topMovieViewController = setupViewController(name_storyboard: Storyboard.topMovie, id: Storyboard_id.topMovie)
        libraryViewController = setupViewController(name_storyboard: Storyboard.library, id: Storyboard_id.library)
        searchViewController = setupViewController(name_storyboard: Storyboard.search, id: Storyboard_id.search)
        feedbackViewController = setupViewController(name_storyboard: Storyboard.feedback, id: Storyboard_id.feedback)
        
        self.viewControllers = [homeViewController,
                                topMovieViewController,
                                libraryViewController,
                                searchViewController,
                                feedbackViewController]
        self.tabBar.tintColor = UIColor(red: 238/255, green: 130/255, blue: 238/255, alpha: 1)
        self.hideHUD()
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected")
    }
    
    private func setupView() {
          self.delegate = self
    }
    
    func setupViewController(name_storyboard: String, id: String) -> UIViewController {
        let storyboard = UIStoryboard(name: name_storyboard, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: id)
        let image = UIImage(named: name_storyboard)
        let tabBarItem = UITabBarItem(title: name_storyboard, image: image, selectedImage: image)
        vc.tabBarItem = tabBarItem
        return vc
    }
}

extension MainViewController: UITabBarControllerDelegate {
}
