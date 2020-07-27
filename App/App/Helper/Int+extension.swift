//
//  Int+extension.swift
//  App
//
//  Created by Sheikh Ahmed on 17/07/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//

import Foundation
enum TimeComponentType: String{
    case minute
    case hour
    case day
}
extension Int {
    func inWords(timeComponent: TimeComponentType)->String{
        var result = ""
        result = self > 1 ? "\(self) \(timeComponent.rawValue)s" : "\(self) \(timeComponent.rawValue)"
        return result
    }
    func toCurrency()->String{
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        let amount = Double(self) / 100.0
        guard let formattedTipAmount = formatter.string(from: amount as NSNumber) else { return ""}
        return formattedTipAmount
    }
    func toTimeDuration()->String{
        var result = ""
        var minute = self
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
}
