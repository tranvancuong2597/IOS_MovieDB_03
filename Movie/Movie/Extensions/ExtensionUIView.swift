//
//  ExtensionUIView.swift
//  Movie
//
//  Created by Da on 8/6/18.
//  Copyright © 2018 Tran Cuong. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func border(width: CGFloat, color: CGColor) {
        self.layer.borderWidth = width
        self.layer.borderColor = color
        self.clipsToBounds = true
    }
}
