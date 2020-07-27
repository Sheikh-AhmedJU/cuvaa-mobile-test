//
//  PolicyEventVM.swift
//  App
//
//  Created by Sheikh Ahmed on 23/07/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//
import RealmSwift
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
        guard let endTime = model?.payload?.endDate  else {
            return false
        }
        return calculateRemainingTime(endDate: endTime) > 0
    }
    public var isExtendedPolicy: Bool {
        model?.payload?.originalPolicyID != model?.payload?.policyID
    }
    public var vehicleLogo: UIImage? {
        model?.payload?.vehicle?.make?.logo
    }
    public var remainingTime: String {
        guard let endTime = model?.payload?.endDate  else {
            return ""
        }
        return calculateRemainingTime(endDate: endTime).toTimeDuration()
    }
    public var vehicleMakeWithModel: String {
        let make = model?.payload?.vehicle?.make?.rawValue ?? ""
        let modelName = model?.payload?.vehicle?.model ?? ""
        return "\(make) \(modelName)"
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
    public var policyDuration: Int {
        guard let startDate = model?.payload?.startDate,
            let endDate = model?.payload?.endDate else {
                return 0
        }
        return calculateRemainingTime(startDate: startDate, endDate: endDate)
    }
    public var policyRemainingDuration: Int {
        guard let endDate = model?.payload?.endDate else {return 0}
        return calculateRemainingTime(startDate: nil, endDate: endDate)
    }
    private func calculateRemainingTime(startDate: String? = nil, endDate: String)->Int{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        guard let eDate = formatter.date(from: endDate) else { return 0 }
        guard let startDate = startDate, let sDate = formatter.date(from: startDate) else {
            return Calendar.current.dateComponents([.minute], from: Date(), to: eDate).minute ?? 0
        }
        return Calendar.current.dateComponents([.minute], from: sDate, to: eDate).minute ?? 0
    }
    
}
