// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let standardText = try? newJSONDecoder().decode(StandardText.self, from: jsonData)

import Foundation

// MARK: - StandardText
struct StandardText: Codable {
    let strings: Strings?
}

// MARK: - Strings
struct Strings: Codable {
    let global: Global?
    let homepage: Homepage?
    let policyDetail: PolicyDetail?
    let motor: Motor?

    enum CodingKeys: String, CodingKey {
        case global, homepage
        case policyDetail = "policy_detail"
        case motor
    }
}

// MARK: - Global
struct Global: Codable {
    let pricing: Pricing?
}

// MARK: - Homepage
struct Homepage: Codable {
    let activeSectionTitle, historicSectionTitle, insureCta, extendCta: String?
    let vrmLabel, policyCountLabel, timeRemainingLabel: String?

    enum CodingKeys: String, CodingKey {
        case activeSectionTitle = "active_section_title"
        case historicSectionTitle = "historic_section_title"
        case insureCta = "insure_cta"
        case extendCta = "extend_cta"
        case vrmLabel = "vrm_label"
        case policyCountLabel = "policy_count_label"
        case timeRemainingLabel = "time_remaining_label"
    }
}

// MARK: - Motor
struct Motor: Codable {
    let policyExpiry, policyExpiryWarning: String?
    let pricing: Pricing?

    enum CodingKeys: String, CodingKey {
        case policyExpiry = "policy_expiry"
        case policyExpiryWarning = "policy_expiry_warning"
        case pricing
    }
}

// MARK: - PolicyDetail
struct PolicyDetail: Codable {
    let title, policyCountLabel, insureCta, extendCta: String?
    let activeSectionTitle, historicSectionTitle: String?

    enum CodingKeys: String, CodingKey {
        case title
        case policyCountLabel = "policy_count_label"
        case insureCta = "insure_cta"
        case extendCta = "extend_cta"
        case activeSectionTitle = "active_section_title"
        case historicSectionTitle = "historic_section_title"
    }
}
