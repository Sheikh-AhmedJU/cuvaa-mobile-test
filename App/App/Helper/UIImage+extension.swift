//
//  UIImage+extension.swift
//  App
//
//  Created by Sheikh Ahmed on 16/07/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//

import UIKit
extension UIImage {
    static func imageWithColor(tintColor: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        tintColor.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}
