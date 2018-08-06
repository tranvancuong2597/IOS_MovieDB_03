//
//  ExtensionUIViewController.swift
//  Movie
//
//  Created by Da on 8/5/18.
//  Copyright © 2018 Tran Cuong. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

extension UIViewController {
    func borderViews(views: UIView...) {
        for view in views {
            view.border(width: 0.5, color: UIColor.white.cgColor)
        }
    }
    
    func showHud(_ message: String) {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = message
        hud.isUserInteractionEnabled = false
    }
    
    func hideHUD() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
}
