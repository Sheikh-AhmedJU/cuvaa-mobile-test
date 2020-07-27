//
//  PolicyModel.swift
//  App
//
//  Created by Sheikh Ahmed on 26/07/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//

import Foundation
import RealmSwift
import UIKit

class PolicyDTO: Object {
    @objc dynamic var policyType: String =  ""
    @objc dynamic var timeStamp: String = ""
    @objc dynamic var uniqueKey: String = ""
    @objc dynamic var payload: PayloadDTO?
}

class PayloadDTO: Object {
    @objc dynamic var policyID: String = ""
    @objc dynamic var userID: String = ""
    @objc dynamic var userRevision: String = ""
    @objc dynamic var originalPolicyID: String = ""
    @objc dynamic var referenceCode: String = ""
    @objc dynamic var startDate: String = ""
    @objc dynamic var endDate: String = ""
    @objc dynamic var incidentPhone: String = ""
    @objc dynamic var type: String = ""
    @objc dynamic var modifiedEndDate: String = ""
    @objc dynamic var vehicle: VehicleDTO?
    @objc dynamic var realmDocuments: DocumentDTO?
    @objc dynamic var pricing: PriceDTO?
}

class VehicleDTO: Object {
    @objc dynamic var vrm: String = ""
    @objc dynamic var prettyVrm: String = ""
    @objc dynamic var make: String = ""
    @objc dynamic var model: String = ""
    @objc dynamic var variant: String = ""
    @objc dynamic var color: String = ""
}
class DocumentDTO: Object {
    @objc dynamic var certificateURL: String = ""
    @objc dynamic var termsURL: String = ""
}
class PriceDTO: Object {
    @objc dynamic var underwriterPremium: Int = 0
    @objc dynamic var commission: Int = 0
    @objc dynamic var totalPremium: Int = 0
    @objc dynamic var ipt: Int = 0
    @objc dynamic var iptRate: Int = 0
    @objc dynamic var extraFees: Int = 0
    @objc dynamic var vat: Int = 0
    @objc dynamic var deductions: Int = 0
    @objc dynamic var totalPayable: Int = 0
}

extension PolicyEventModel: MappableProtocol {
    func mapToPersistenceObject() -> PolicyDTO {
        let model = PolicyDTO()
        model.timeStamp = self.timestamp ?? ""
        model.policyType = self.type?.rawValue ?? ""
        model.uniqueKey = self.uniqueKey ?? ""
        model.payload = self.payload?.mapToPersistenceObject()
        return model
    }
    static func mapFromPersistenceObject(_ object: PolicyDTO) -> PolicyEventModel {
        let payload = Payload.mapFromPersistenceObject(object.payload ?? PayloadDTO())
        return PolicyEventModel(type: PolicyEventType(rawValue: object.policyType), timestamp: object.timeStamp, uniqueKey: object.uniqueKey, payload: payload)
    }
}
