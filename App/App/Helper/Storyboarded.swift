//
//  Storyboarded.swift
//  App
//
//  Created by Sheikh Ahmed on 16/07/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//

import Foundation
import UIKit

protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: id) as? Self else {
            fatalError("Could not instantaiate view controller with ID \"\(id)\"")
        }
        
        return vc
    }
}
