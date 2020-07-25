//
//  UIColor+extension.swift
//  App
//
//  Created by Sheikh Ahmed on 15/07/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//

import UIKit




enum AppColors{
    // background colors
    static let darkBackground = UIColor(rgb: 0x29198D)
    static let policyNavigationBackground = UIColor(rgb: 0x5C5CFF)
    static let recieptNavigationBackground = lightBackground
    static let lightBackground = UIColor(rgb: 0xEFEDFF)
    static let veryLightBackground = UIColor(rgb: 0x5A55FF)
    static let activePolicyButtonBackground = UIColor(rgb: 0x1CC686)
    
    // text color
    static let darkHeader = UIColor(rgb: 0x161656)
    static let lightHeader = AppColors.lightBackground
    static let darkSubheader = UIColor(rgb: 0x5D5DAE)
    static let buttonWithImageHeader = AppColors.darkBackground
    static let buttonWithImageSubHeader = AppColors.darkHeader
    static let lightGrey = UIColor(rgb: 0xBCBCBC)
    static let insureButton = AppColors.veryLightBackground
    static let remainingTime = AppColors.veryLightBackground
 
    case textColor(labelType: LabelType)
    case buttonTextColor(buttonType: ButtonType)
    case buttonBackgroundColor(buttonType: ButtonType)
    
    var color: UIColor? {
        switch self {
        case .textColor(let labelType):
            switch labelType {
            case .headerInImageButton: return AppColors.veryLightBackground
            case .subHeaderInImageButton: return AppColors.darkSubheader
            case .bulletInImageButton(let isAvailable):
                return isAvailable ? AppColors.activePolicyButtonBackground : AppColors.lightGrey
            case .headerInTableCell: return AppColors.darkHeader
            case .subHeaderInTableCell: return AppColors.darkSubheader
            case .regularInTableCell: return AppColors.remainingTime
            case .tableViewHeader: return AppColors.darkSubheader
            case .lightGrey: return AppColors.lightGrey
            }
        case .buttonTextColor(let buttonType):
            switch buttonType {
            case .extend: return UIColor.white
            case .insure: return AppColors.insureButton
            }
        case .buttonBackgroundColor(let buttonType):
            switch buttonType {
            case .extend: return AppColors.activePolicyButtonBackground
            case .insure: return AppColors.lightBackground
            }
        }
    }
}




extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}
