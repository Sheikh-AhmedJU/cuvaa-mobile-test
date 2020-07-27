//
//  UIViewTest.swift
//  AppTests
//
//  Created by Sheikh Ahmed on 27/07/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//

import XCTest
@testable import App
class UIViewTest: XCTestCase {
    func testRoundedView(){
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 50, height: 50)))
        view.setRounded()
        XCTAssertEqual(view.layer.cornerRadius, 25)
    }
    func testVehicleLogo(){
        var logo = Make.mercedesBenz.logo
        XCTAssertEqual(logo, UIImage(named: "mercedes-benz"))
        logo = Make.mini.logo
        XCTAssertEqual(logo, UIImage(named: "mini"))
        logo = Make.volkswagen.logo
        XCTAssertEqual(logo, UIImage(named: "volkswagen"))
        logo = Make(rawValue: "")?.logo
        XCTAssertNil(logo)
    }
}
