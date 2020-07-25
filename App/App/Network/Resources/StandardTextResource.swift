//
//  StandardTextResource.swift
//  App
//
//  Created by Sheikh Ahmed on 15/07/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//

import Foundation

struct StandardTextResource{
    
}

extension StandardTextResource: ResourceType {
    var baseURL: URL {
        guard let url = URL(string: AppURLs.standardText.baseURL) else { fatalError("Base url for Standard Text could not be configured.") }
        return url
    }
    var path: String {
        return "/v2/5c699176370000a90a07fd6f"
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
