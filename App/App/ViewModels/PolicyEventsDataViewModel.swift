//
//  PolicyEventsData.swift
//  App
//
//  Created by Sheikh Ahmed on 16/07/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//

import UIKit

class PolicyEventsDataViewModel{
    private let _payload: Payload
    public init(payload: Payload){
        _payload = payload
    }
    public var userID: String {
        _payload.userID ?? ""
    }
    public var userRevision: String {
        _payload.userRevision ?? ""
    }
    public var policyID: String {
        _payload.policyID ?? ""
    }
    public var originalPolicyID: String {
        _payload.originalPolicyID ?? ""
    }
    public var referenceCode: String {
        _payload.referenceCode ?? ""
    }
    public var startDate: String {
        _payload.startDate ?? ""
    }
    public var endDate: String {
        _payload.endDate ?? ""
    }
    public var incidentPhone: String {
        _payload.incidentPhone ?? ""
    }
    public var vehicleVRM: String {
        _payload.vehicle?.vrm ?? ""
    }
    public var prettyVRM: String {
        _payload.vehicle?.prettyVrm ?? ""
    }
    public var vehicleMake: String {
        _payload.vehicle?.make?.rawValue ?? ""
    }
    public var vehicleLogo: UIImage? {
        _payload.vehicle?.make?.logo
    }
    public var vehicleModel: String {
        _payload.vehicle?.model ?? ""
    }
    public var vehicleVariant: String {
        _payload.vehicle?.variant ?? ""
    }
    public var vehicleColor: String {
        _payload.vehicle?.color?.rawValue ?? ""
    }
}

