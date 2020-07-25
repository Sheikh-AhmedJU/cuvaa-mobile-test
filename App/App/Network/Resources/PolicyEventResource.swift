//
//  PolicyEventResource.swift
//  App
//
//  Created by Sheikh Ahmed on 15/07/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//

import Foundation

struct PolicyEventResource{
    
}

extension PolicyEventResource: ResourceType {
    var baseURL: URL {
        guard let url = URL(string: AppURLs.policy.baseURL) else { fatalError("Base url for Policy could not be configured.") }
        return url
    }
    var path: String {
        return ""
    }
    var parameter: Parameters {
        let param = [String: String]()
        return param
    }
    var httpMethod: HTTPMethod {
        return .get
    }
    var task: HTTPTask {
        return .requestParametersAndHeaders(bodyParameters: nil, bodyEncoding: .urlEncoding , urlParameters: parameter, additionHeaders: nil)
    }
}
