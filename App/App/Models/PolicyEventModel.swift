// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let policyEvent = try? newJSONDecoder().decode(PolicyEvent.self, from: jsonData)

import Foundation
import UIKit


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

// MARK: - Documents
struct Documents: Codable, Hashable {
    let certificateURL, termsURL: String?

    enum CodingKeys: String, CodingKey {
        case certificateURL = "certificate_url"
        case termsURL = "terms_url"
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

// MARK: - Vehicle
struct Vehicle: Codable, Hashable {
    let vrm, prettyVrm: String?
    let make: Make?
    let model, variant: String?
    let color: Color?
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

