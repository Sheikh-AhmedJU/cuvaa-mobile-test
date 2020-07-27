// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let policyEvent = try? newJSONDecoder().decode(PolicyEvent.self, from: jsonData)

import Foundation
import UIKit
import RealmSwift

// MARK: - PolicyEventType
enum PolicyEventType: String, Codable {
    case policyCancelled = "policy_cancelled"
    case policyCreated = "policy_created"
    case policyFinancialTransaction = "policy_financial_transaction"
}

// MARK: - PolicyEventElement
struct PolicyEventModel: Codable, Hashable {
    static func == (lhs: PolicyEventModel, rhs: PolicyEventModel) -> Bool {
        lhs.payload?.vehicle?.make?.rawValue == rhs.payload?.vehicle?.make?.rawValue
    }
    
    let type: PolicyEventType?
    let timestamp, uniqueKey: String?
    let payload: Payload?

    enum CodingKeys: String, CodingKey {
        case type, timestamp
        case uniqueKey = "unique_key"
        case payload
    }
}

// MARK: - Payload
struct Payload: Codable, Hashable {
    static func == (lhs: Payload, rhs: Payload) -> Bool {
        lhs.vehicle?.make?.rawValue == rhs.vehicle?.make?.rawValue
    }
    
    let userID: String?
    let userRevision: String?
    let policyID, originalPolicyID, referenceCode, startDate: String?
    let endDate, incidentPhone: String?
    let vehicle: Vehicle?
    let documents: Documents?
    let pricing: Pricing?
    let type: String?
    let newEndDate: String?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case userRevision = "user_revision"
        case policyID = "policy_id"
        case originalPolicyID = "original_policy_id"
        case referenceCode = "reference_code"
        case startDate = "start_date"
        case endDate = "end_date"
        case incidentPhone = "incident_phone"
        case vehicle, documents, pricing, type
        case newEndDate = "new_end_date"
    }
}

extension Payload: MappableProtocol{
    func mapToPersistenceObject() -> PayloadDTO {
        let model = PayloadDTO()
        model.policyID = self.policyID ?? ""
        model.userID = self.userID ?? ""
        model.userRevision = self.userRevision ?? ""
        model.originalPolicyID = self.originalPolicyID ?? ""
        model.referenceCode = self.referenceCode ?? ""
        model.startDate = self.startDate ?? ""
        model.endDate = self.endDate ?? ""
        model.incidentPhone = self.incidentPhone ?? ""
        model.type = self.type ?? ""
        model.modifiedEndDate = self.newEndDate ?? ""
        model.vehicle = self.vehicle?.mapToPersistenceObject()
        model.realmDocuments = self.documents?.mapToPersistenceObject()
        model.pricing = self.pricing?.mapToPersistenceObject()
        return model
    }
    static func mapFromPersistenceObject(_ object: PayloadDTO) -> Payload {
        let vehicle = Vehicle.mapFromPersistenceObject(object.vehicle ?? VehicleDTO())
        let documents = Documents.mapFromPersistenceObject(object.realmDocuments ?? DocumentDTO())
        let pricing = Pricing.mapFromPersistenceObject(object.pricing ?? PriceDTO())
        
        return Payload(userID: object.userID, userRevision: object.userRevision, policyID: object.policyID, originalPolicyID: object.originalPolicyID, referenceCode: object.referenceCode, startDate: object.startDate, endDate: object.endDate, incidentPhone: object.incidentPhone, vehicle: vehicle, documents: documents, pricing: pricing, type: object.type, newEndDate: object.modifiedEndDate)
    }

}



// MARK: - Documents
struct Documents: Codable, Hashable {
    let certificateURL, termsURL: String?

    enum CodingKeys: String, CodingKey {
        case certificateURL = "certificate_url"
        case termsURL = "terms_url"
    }
}

extension Documents: MappableProtocol {
    func mapToPersistenceObject() -> DocumentDTO {
        let model = DocumentDTO()
        model.certificateURL = self.certificateURL ?? ""
        model.termsURL = self.termsURL ?? ""
        return model
    }
    static func mapFromPersistenceObject(_ object: DocumentDTO) -> Documents {
        return Documents(certificateURL: object.certificateURL, termsURL: object.termsURL)
    }
}


// MARK: - Pricing
struct Pricing: Codable, Hashable {
    let underwriterPremium, commission, totalPremium, ipt: Int?
    let iptRate, extraFees, vat, deductions: Int?
    let totalPayable: Int?

    enum CodingKeys: String, CodingKey {
        case underwriterPremium = "underwriter_premium"
        case commission
        case totalPremium = "total_premium"
        case ipt
        case iptRate = "ipt_rate"
        case extraFees = "extra_fees"
        case vat, deductions
        case totalPayable = "total_payable"
    }
}

extension Pricing: MappableProtocol {
    func mapToPersistenceObject() -> PriceDTO {
        let model = PriceDTO()
        model.commission = self.commission ?? 0
        model.deductions = self.deductions ?? 0
        model.extraFees = self.extraFees ?? 0
        model.ipt = self.ipt ?? 0
        model.iptRate = self.iptRate ?? 0
        model.extraFees = self.extraFees ?? 0
        model.vat = self.vat ?? 0
        model.deductions = self.deductions ?? 0
        model.totalPayable = self.totalPayable ?? 0
        return model
    }
    static func mapFromPersistenceObject(_ object: PriceDTO) -> Pricing {
        
        return Pricing(underwriterPremium: object.underwriterPremium, commission: object.commission, totalPremium: object.totalPremium, ipt: object.ipt, iptRate: object.iptRate, extraFees: object.extraFees, vat: object.vat, deductions: object.deductions, totalPayable: object.totalPayable)
    }
}


// MARK: - Vehicle
struct Vehicle: Codable, Hashable {
    let vrm, prettyVrm: String?
    let make: Make?
    let model, variant: String?
    let color: Color?
}

extension Vehicle: MappableProtocol {
    func mapToPersistenceObject() -> VehicleDTO {
        let model = VehicleDTO()
        model.vrm = self.vrm ?? ""
        model.prettyVrm = self.prettyVrm ?? ""
        model.make = self.make?.rawValue ?? ""
        model.model = self.model ?? ""
        model.variant = self.variant ?? ""
        model.color = self.color?.rawValue ?? ""
        return model
    }
    static func mapFromPersistenceObject(_ object: VehicleDTO) -> Vehicle {
        return Vehicle(vrm: object.vrm, prettyVrm: object.prettyVrm, make: Make(rawValue: object.make), model: object.model, variant: object.variant, color: Color(rawValue: object.color))
    }

}


enum Color: String, Codable {
    case beige = "Beige"
    case blue = "Blue"
    case gold = "Gold"
    case silver = "Silver"
}

enum Make: String, Codable {
    case ford = "Ford"
    case mercedesBenz = "Mercedes-Benz"
    case mini = "MINI"
    case nissan = "Nissan"
    case volkswagen = "Volkswagen"
}
extension Make {
    var logo: UIImage? {
        switch self {
        case .mercedesBenz: return UIImage(named: "mercedes-benz")
        case .mini: return UIImage(named: "mini")
        case .volkswagen: return UIImage(named: "volkswagen")
        default: return UIImage(named: "motor")
        }
    }
}


typealias PolicyEvents = [PolicyEventModel]

