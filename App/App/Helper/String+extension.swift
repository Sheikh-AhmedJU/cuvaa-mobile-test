//
//  String+extension.swift
//  App
//
//  Created by Sheikh Ahmed on 16/07/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//

import UIKit

extension String {
    // MARK:- Get the attrbuted text from a string
    func getAttributedTitle(font: UIFont?, textColor: UIColor?)->NSAttributedString? {
        guard let font = font, let color = textColor else { return nil}
        let titleAttributes = [NSAttributedString.Key.font: font,
                               NSAttributedString.Key.foregroundColor: color]
        let titleAttributedString = NSAttributedString(string: self, attributes: titleAttributes)
        return titleAttributedString
    }
    func getAttributedBullet(isAvailable: Bool)->NSAttributedString? {
        var font = AppFonts.labelFont(labelType: .bulletInImageButton(isAvailable: isAvailable)).font
        var color = AppColors.textColor(labelType: .bulletInImageButton(isAvailable: isAvailable)).color
        let bulletText = "\n \u{2022}".getAttributedTitle(font: font, textColor: color)
        font = AppFonts.labelFont(labelType: .subHeaderInImageButton).font
        color = AppColors.textColor(labelType: .subHeaderInImageButton).color
        let avialabilityText = self.getAttributedTitle(font: font, textColor: color)
        let result = NSMutableAttributedString()
        guard let bText = bulletText, let aText = avialabilityText else { return nil }
        result.append(bText)
        result.append(aText)
        return result
    }
    func getDateOnly()->String?{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        guard let date = formatter.date(from: self) else { return nil}
        let newDateFormat = DateFormatter()
        newDateFormat.dateFormat = "E, d MMM yyyy"
        return newDateFormat.string(from: date)
    }
    func getTimeOnly()->String?{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        guard let date = formatter.date(from: self) else { return nil}
        let newDateFormat = DateFormatter()
        newDateFormat.dateFormat = "HH:mm"
        return newDateFormat.string(from: date)
    }
    func getDateAndTime()->Date?{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        guard let date = formatter.date(from: self) else { return nil}
        return date
    }
}
