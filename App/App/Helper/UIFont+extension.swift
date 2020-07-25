//
//  UIFont+extension.swift
//  App
//
//  Created by Sheikh Ahmed on 15/07/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//

import UIKit

enum AppFonts {
    enum SF {
        static func bold(ofSize size: CGFloat) -> UIFont {
            return UIFont(name: "SFProText-Bold", size: size)!
        }
        static func regular(ofSize size: CGFloat) -> UIFont {
            return UIFont(name: "SFProDisplay-Regular", size: size)!
        }
        static func semiBold(ofSize size: CGFloat) -> UIFont {
            return UIFont(name: "SFProDisplay-Semibold", size: size)!
        }
        static func light(ofSize size: CGFloat) -> UIFont {
            return UIFont(name: "SFProDisplay-Light", size: size)!
        }
    }
    // Button fonts
    static let buttonWithImageHeader = SF.bold(ofSize: 14)
    static let buttonWithImageSubheader = SF.bold(ofSize: 10)
    static let buttonWithImageBullet = SF.bold(ofSize: 16)
    static let policyButton = SF.bold(ofSize: 16)
    
    // label fonts
    static let tableViewCellHeader = SF.bold(ofSize: 16)
    static let tableViewCellSubheader = SF.regular(ofSize: 13)
    static let tableViewRegular = SF.regular(ofSize: 13)
    static let tableHeader = SF.bold(ofSize: 13)
    static let bigRegistrationPlate = SF.bold(ofSize: 20)
    
    
    case labelFont(labelType: LabelType)
    case buttonFont(buttonType: ButtonType)
    
    var font: UIFont? {
        switch self {
        case .labelFont(let labelType):
            switch labelType {
            case .headerInImageButton: return AppFonts.buttonWithImageHeader
            case .subHeaderInImageButton: return AppFonts.buttonWithImageSubheader
            case .bulletInImageButton(_):
                return AppFonts.buttonWithImageBullet
            case .headerInTableCell: return AppFonts.tableViewCellHeader
            case .subHeaderInTableCell: return AppFonts.tableViewCellSubheader
            case .regularInTableCell: return AppFonts.tableViewRegular
            case .tableViewHeader: return AppFonts.tableHeader
            case .lightGrey: return AppFonts.tableViewRegular
            }
        case .buttonFont(_):
            return AppFonts.tableViewCellHeader
        }
    }
}
