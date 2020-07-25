//
//  PolicyEventVM.swift
//  App
//
//  Created by Sheikh Ahmed on 23/07/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//

import Foundation
import UIKit

class PolicyEventVM: Hashable{
    static func == (lhs: PolicyEventVM, rhs: PolicyEventVM) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
    
    public func hash(into hasher: inout Hasher) {
         hasher.combine(ObjectIdentifier(self).hashValue)
    }
    
    private var model: PolicyEventModel?
    init(policyEventModel: PolicyEventModel){
        self.model = policyEventModel
    }
    public var policyID: String{
        model?.payload?.policyID ?? ""
    }
    public var isFinancialTransaction: Bool {
        model?.type == .policyFinancialTransaction
    }
    public var isCancelled: Bool {
        model?.type == .policyCancelled
    }
    public var isNewPolicy: Bool {
        model?.type == .policyCreated
    }
    public var vehicleMake: String{
        model?.payload?.vehicle?.make?.rawValue ?? ""
    }
    public var vehicleModelWithColor: String {
        let modelName = model?.payload?.vehicle?.model ?? ""
        let color = model?.payload?.vehicle?.color?.rawValue ?? ""
        return "\(color) \(modelName)"
    }
    public var registrationPlate: String {
        model?.payload?.vehicle?.prettyVrm ?? ""
    }
    public var isActivePolicy: Bool {
        let endTime = model?.payload?.endDate
        return !getRemainingTime(endDate: endTime).isEmpty
    }
    public var isExtendedPolicy: Bool {
        model?.payload?.originalPolicyID != model?.payload?.policyID
    }
    public var vehicleLogo: UIImage? {
        model?.payload?.vehicle?.make?.logo
    }
    public var remainingTime: String {
        let endTime = model?.payload?.endDate
        return getRemainingTime(endDate: endTime)
    }
    public var vehicleMakeWithModel: String {
        let make = model?.payload?.vehicle?.make?.rawValue ?? ""
        let modelName = model?.payload?.vehicle?.model ?? ""
        return "\(make) \(modelName)"
    }
    public var policyDuration: String {
        let startTime = model?.payload?.startDate
        let endtIme = model?.payload?.endDate
        return getRemainingTime(endDate: endtIme, startDate: startTime)
    }
    public var policyUpdateDate: String {
        model?.timestamp?.getDateOnly() ?? ""
    }
    public var policyUpdateTime: String {
        model?.timestamp?.getTimeOnly() ?? ""
    }
    public var insurancePremium: Int {
        model?.payload?.pricing?.totalPremium ?? 0
    }
    public var insurancePremiumTax: Int {
        model?.payload?.pricing?.ipt ?? 0
    }
    public var adminFee: Int {
        model?.payload?.pricing?.extraFees ?? 0
    }
    public var totalPaid: Int {
        model?.payload?.pricing?.totalPayable ?? 0
    }
    public var timeStamp: String {
        model?.timestamp ?? ""
    }
    
}
