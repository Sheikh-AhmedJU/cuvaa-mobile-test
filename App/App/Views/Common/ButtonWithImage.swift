//
//  ButtonWithImage.swift
//  App
//
//  Created by Sheikh Ahmed on 15/07/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//

import UIKit

class ButtonWithImage: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let imageView = imageView else {return }
        imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: (bounds.width - 35))
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: (imageView.frame.width))
        self.titleLabel?.numberOfLines = 2
        self.layer.cornerRadius = 10
        self.titleLabel?.textAlignment = .center
    }
    func setBackgroundColor(color: UIColor?){
        self.backgroundColor = color
    }
}
