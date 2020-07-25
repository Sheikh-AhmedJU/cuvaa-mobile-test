//
//  AppErrors.swift
//  App
//
//  Created by Sheikh Ahmed on 15/07/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//

import Foundation
enum APPErrors: Error{
    case failedToGetLocationData
    case failedToGetTimeZone
    case failedToGetCalenderInfo
    case failedToCalculateForSelectedLocation
    case other(message: String)
    var localizedDescription: String{
        switch self{
        default: return "\(self)"
        }
    }
}

enum APIError: Error {
    case noService
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case badRequest
    case internalServerError
    case unauthorized
    case responseUnsuccessful
    case jsonParsingFailure
    case other(message: String)

    var localizedDescription: String {
        switch self {
        case .noService: return "no internet connection"
        case .jsonConversionFailure: return "json conversion failure"
        case .jsonParsingFailure: return "json parsing failure"
        case .invalidData: return "invalid data"
        case .badRequest: return "bad request"
        case .internalServerError: return "Internal server error occured"
        case .unauthorized: return "Unauthorized request"
        case .responseUnsuccessful: return "response unsuccessful"
        default: return "something went wrong: \(self)"
        }
    }
}
