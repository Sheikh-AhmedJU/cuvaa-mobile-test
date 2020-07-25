//
//  NibBased.swift
//  App
//
//  Created by Sheikh Ahmed on 16/07/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//


import UIKit

protocol NibBased {
    static var nibName: String { get }
}

extension NibBased {
    static var nibName: String {
        return String(describing: self)
    }
    static var nib: UINib? {
        return UINib(nibName: nibName, bundle: nil)
    }
}

