//
//  Global.swift
//  App
//
//  Created by Sheikh Ahmed on 15/07/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//

import Foundation
import UIKit
enum AppURLs{
    case policy
    case standardText
    var baseURL: String {
        switch self {
        case .policy: return "https://cuvva.herokuapp.com/"
        case .standardText: return "http://www.mocky.io/v2/5c699176370000a90a07fd6f"
        }
    }
}

public enum ButtonType{
    case extend
    case insure
}
public enum TableViewLabelType{
    case header
    case subHeader
    case regular
}
public enum ButtonWithImageType{
    case withSubheader
    case withoutSubheader
}
public enum LabelType{
    case headerInImageButton
    case subHeaderInImageButton
    case bulletInImageButton(isAvailable: Bool)
    case headerInTableCell
    case subHeaderInTableCell
    case regularInTableCell
    case tableViewHeader
    case lightGrey
}

public enum AppAssets{
    case user
    case help
    case motor
    case aeroplane
    var image: UIImage? {
        switch self {
        case .user: return UIImage(named: "user")
        case .help: return UIImage(named: "help")
        case .motor: return UIImage(named: "motor")
        case .aeroplane: return UIImage(named: "aeroplane")
        }
    }
}

public enum NavigationButtonPosition {
    case left
    case right
}

