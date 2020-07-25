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
}
