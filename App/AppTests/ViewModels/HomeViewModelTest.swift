//
//  HomeViewModelTest.swift
//  AppTests
//
//  Created by Sheikh Ahmed on 27/07/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//

import XCTest
import RealmSwift

@testable import App
class HomeViewModelTest: XCTestCase {
    var sut: HomeViewModel?
    var dbManager: DataBaseManager?
    
    override func setUp() {
        let realm = try? Realm(configuration: Realm.Configuration(inMemoryIdentifier: "MyInMemoryRealm"))
        let dbManager = RealmDataBaseManager(realm)
        sut = HomeViewModel(dbManager: dbManager)
    }
    override func tearDown() {
        try! dbManager?.deleteAll(PolicyDTO.self)
        sut = nil
        dbManager = nil
    }
    private func createPolicyEvent(withRegPlate regPlate: String?, andPolicyID policyID: String?)->PolicyEventModel{
        let vehicle = Vehicle(vrm: regPlate, prettyVrm: regPlate, make: nil, model: nil, variant: nil, color: nil)
        return PolicyEventModel(type: PolicyEventType.policyCreated, timestamp: "", uniqueKey: "", payload: Payload(userID: "", userRevision: "", policyID: policyID, originalPolicyID: policyID, referenceCode: "", startDate: "", endDate: "", incidentPhone: "", vehicle: vehicle, documents: nil, pricing: nil, type: "", newEndDate: ""))
    }
    
    func testNavigationBarTintColor(){
        XCTAssertEqual(sut?.getNavigationBarTintColor(), AppColors.darkBackground)
    }
    func testNavigationBarTitleTextAttributes(){
        XCTAssertEqual(sut?.getNavigationBarTitleTextAttributes(), [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: AppFonts.labelFont(labelType: .tableViewHeader).font ?? UIFont()])
    }
    
    func testavigationButton(){
        XCTAssertEqual(sut?.getNavigationButton(buttonPosition: .left), UIImage(named: "Icon-20"))
        XCTAssertEqual(sut?.getNavigationButton(buttonPosition: .right), UIImage(named: "Icon-21"))
    }
    func testGetBackgroundColor(){
        XCTAssertEqual(sut?.getBackgroundColor(), AppColors.darkBackground)
    }
    func testGetImageForButton(){
        var asset: AppAssets = .aeroplane
        XCTAssertEqual(sut?.getImageforButton(asset: asset), asset.image)
        asset = .help
        XCTAssertEqual(sut?.getImageforButton(asset: asset), asset.image)
        asset = .motor
        XCTAssertEqual(sut?.getImageforButton(asset: asset), asset.image)
        asset = .user
        XCTAssertEqual(sut?.getImageforButton(asset: asset), asset.image)
    }
    func testGetTableViewBackgroundColor(){
        XCTAssertEqual(sut?.getTableViewBackgroundColor(),  AppColors.lightBackground)
    }
    func testGetAllpolicies(){
        loadMockPolicy()
        let expectation = self.expectation(description: "getPolicies")
        sut?.fetchPolicies(completion: { (_) in
            expectation.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(self.sut?.getAllPolicies(for: "Plate 1").count, 1)
    }
    func testGetCellData(){
        var list: [PolicyEventVM] = []
        loadMockPolicy()
        let expectation = self.expectation(description: "getPolicies")
        sut?.fetchPolicies(completion: { (_) in
            guard let policiesList = self.sut?.getCellData(for: IndexPath(row: 0, section: 0)) else { return}
            list = policiesList
            expectation.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssert(!list.isEmpty)
    }
    private func loadMockPolicy(){
        let registrationPlate = "Plate 1"
        let policyEventModel = createPolicyEvent(withRegPlate: registrationPlate, andPolicyID: nil)
        guard let dbManager = sut?.dbManager else { return }
        let policyRepo = PolicyRepository(dbManager: dbManager)
        policyRepo.savePolicy(policy: policyEventModel)
        sut?.loadFromLocalRepository = true
    }
    func testGetHeaderView(){
        loadMockPolicy()
        let expectation = self.expectation(description: "getPolicies")
        sut?.fetchPolicies(completion: { (_) in
            expectation.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
        let headerView = sut?.getHeaderView(for: 0)
        XCTAssertNotNil(headerView)
        XCTAssertEqual(sut?.getNumberOfSections(), 1)
        XCTAssertEqual(sut?.getNumberOfRowsInSection(for: 0), 1)
        XCTAssertEqual(sut?.getHeightForHeaderInSection(section: 0), 35)
    }
}
