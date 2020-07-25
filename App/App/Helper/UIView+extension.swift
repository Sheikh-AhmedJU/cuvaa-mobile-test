//
//  UIImageView+extension.swift
//  App
//
//  Created by Sheikh Ahmed on 24/07/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//

import UIKit
extension UIView {
    func setRounded() {
        let radius = self.frame.width / 2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}

