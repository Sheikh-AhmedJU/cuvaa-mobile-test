//
//  HelperFunctionalitiesTest.swift
//  AppTests
//
//  Created by Sheikh Ahmed on 27/07/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//

import XCTest
@testable import App
class HelperFunctionalitiesTest: XCTestCase {
    func testIntExtensions(){
        var minute = 0
        XCTAssertEqual(minute.inWords(timeComponent: .minute), "0 minute")
        minute = 1
        XCTAssertEqual(minute.inWords(timeComponent: .minute), "1 minute")
        minute = 2
        XCTAssertEqual(minute.inWords(timeComponent: .minute), "2 minutes")
    }
    func testToCurrency(){
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        let currenySymbol = formatter.currencySymbol!
        let amount = 20099
        XCTAssertEqual(amount.toCurrency(), "\(currenySymbol)200.99")
    }
    func testToTimeDuration(){
        let minutes = 9598
        XCTAssertEqual(minutes.toTimeDuration(), "6 days, 15 hours, 58 minutes")
    }
    func testGetDateOnly(){
        let date = "2019-01-18T10:15:29.979Z"
        XCTAssertEqual(date.getDateOnly(), "Fri, 18 Jan 2019")
    }
    func testGetTimeOnly(){
        let date = "2019-01-18T10:15:29.979Z"
        XCTAssertEqual(date.getTimeOnly(), "10:15")
    }
    func testGetDateAndTime(){
        let date = "2019-01-18T10:15:29.979Z"
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let newDate = formatter.date(from: date)
        XCTAssertEqual(date.getDateAndTime(), newDate)
    }
}
