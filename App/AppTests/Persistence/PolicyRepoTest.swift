//
//  PolicyRepoTest.swift
//  AppTests
//
//  Created by Sheikh Ahmed on 27/07/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//

import XCTest
import RealmSwift
@testable import App
class PolicyRepoTest: XCTestCase {
    func testGetAllPoliciesMethod(){
        let realm = try? Realm(configuration: Realm.Configuration(inMemoryIdentifier: "MyInMemoryRealm"))
        let dbManager = RealmDataBaseManager(realm)
        let date = Date().description
        let policyEventModel = PolicyEventModel(type: PolicyEventType.policyCreated, timestamp: date, uniqueKey: "key 1", payload: nil)
        //let policyDTO = policyEventModel.mapToPersistenceObject()
        let policyRepo = PolicyRepository(dbManager: dbManager)
        
        policyRepo.savePolicy(policy: policyEventModel)
        policyRepo.getAllPolicies { (policies) in
            
            let policyEventModel = policies[0]
            XCTAssertEqual(policyEventModel.type!, PolicyEventType(rawValue: PolicyEventType.policyCreated.rawValue))
            XCTAssertEqual(policyEventModel.timestamp!, date)
            XCTAssertEqual(policyEventModel.uniqueKey!, "key 1")
        }
        
        policyRepo.deleteAllPolicies()
        policyRepo.fetch(PolicyDTO.self, predicate: nil, sorted: nil) { (policies) in
            XCTAssert(policies.isEmpty)
        }
    }
}
