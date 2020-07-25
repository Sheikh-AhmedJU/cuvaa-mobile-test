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

public enum AppSegue{
    case policy
    var identifier: String {
        switch self {
        case .policy:
            return "showPolicy"
        }
    }
}

public enum NavigationButtonPosition {
    case left
    case right
}

func getRemainingTime(endDate: String?, startDate: String? = nil)->String {
    var result = ""
    guard let endDate = endDate else {return "" }
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    guard let eDate = formatter.date(from: endDate)
        else { return "" }
    var cDate = Date()
    if let startDate = startDate, let sDate = formatter.date(from: startDate) {
        cDate = sDate
    }
    var difference: Int = 0
    if startDate == nil {
       difference = Calendar.current.dateComponents([.minute], from: cDate, to: eDate).minute ?? 0
    } else {
    difference = Calendar.current.dateComponents([.minute], from: cDate, to: eDate).minute ?? 0
    }
    var minute = difference
    let day = minute / (60*24)
    minute -= day * (60 * 24)
    let hour = minute / 60
    minute -= hour * 60
    let dayString = day > 0 ? day.inWords(timeComponent: .day) : ""
    let hourString = hour > 0 ? hour.inWords(timeComponent: .hour) : ""
    let minuteString = minute > 0 ? minute.inWords(timeComponent: .minute) : ""
    result = [dayString, hourString, minuteString].filter({
        !$0.isEmpty
    }).joined(separator: ", ")
    return result
}
