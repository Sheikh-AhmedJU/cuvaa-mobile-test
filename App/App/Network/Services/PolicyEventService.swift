//
//  PolicyEventService.swift
//  App
//
//  Created by Sheikh Ahmed on 15/07/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//

import Foundation
protocol PolicyEventServiceType {
    func getPolicyEvents(completion: @escaping(Result<PolicyEvents?,APIError>)->Void)
}

class PolicyEventService: PolicyEventServiceType {
    
    var requestManager: RequestManager = RequestManager()
    
    func getPolicyEvents(completion: @escaping (Result<PolicyEvents?, APIError>) -> Void) {
        let resource = PolicyEventResource()
        
        guard let request = try? resource.makeRequest() else { return }
        //print(request.url)
        
        requestManager.fetch(with: request, decode: {
            json -> PolicyEvents? in
            
            guard let model = json as? PolicyEvents else { return nil }
            
            return model
        }, completion: completion)
    }
    
    
}
