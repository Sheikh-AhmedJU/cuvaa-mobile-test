//
//  PolicyEventViewModel.swift
//  App
//
//  Created by Sheikh Ahmed on 16/07/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//

import Foundation
import UIKit

class PolicyEventViewModel{
    private let _policyEvents: PolicyEvents
    public init(policyEvents: PolicyEvents){
        _policyEvents = policyEvents
    }
    public var totalPolicies: Int {
        _policyEvents.count
    }
    public var vehicleMake: String {
        _policyEvents.compactMap { $0.payload?.vehicle?.make?.rawValue
        }.first ?? ""
    }
    public var vehicleModelWithColor: String {
        let model = _policyEvents.compactMap {
            $0.payload?.vehicle?.model
        }.first ?? ""
        let color = _policyEvents.compactMap {
            $0.payload?.vehicle?.color?.rawValue
        }.first ?? ""
        return "\(color) \(model)"
    }
    public var registrationPlate: String {
        _policyEvents.compactMap {
            $0.payload?.vehicle?.prettyVrm
        }.first ?? ""
    }
    public var remainingTime: String {
        let eTime = _policyEvents.filter {
            !($0.payload?.endDate?.isEmpty ?? true)
        }.sorted { (lhs, rhs) in
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            guard let lEndDate = lhs.payload?.endDate,
                let rEndDate = rhs.payload?.endDate,
                let lDate = formatter.date(from: lEndDate),
                let rDate = formatter.date(from: rEndDate)
                else {return false}
            return lDate > rDate
            }.first?.payload?.endDate
        return getRemainingTime(endDate: eTime)
    }
    public var isExtendedPolicy: Bool {
        _policyEvents.filter {
            $0.payload?.originalPolicyID != $0.payload?.policyID
        }.count > 0
    }
    public var vehicleLogo: UIImage? {
        _policyEvents.compactMap {
            $0.payload?.vehicle?.make?.logo
        }.first
    }
    
}
