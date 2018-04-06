//
//  APIService.swift
//  workday-solution
//
//  Created by Clinton Buie on 4/6/18.
//  Copyright © 2018 AmateMint. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit
import Realm

// Inherit from Response Object to Return from Request
protocol ResponseObject {
}

extension Bool : ResponseObject {
}

protocol RequestManagerProtocol {
    func requestWithMethod<T:ResponseObject>(_ method: HTTPMethod, apiCall: String, params: [String: AnyObject], headers:[String: String], encoding: Alamofire.ParameterEncoding) -> Promise<T>
}

class APIService {
    
    static let sharedInstance = APIService()
    
    func ping() {
        
    }
    
    func getAllMedia() {
        
    }
    
    func getMediaItem() {
        
    }
    
}

class NetworkManager {
    static let sharedInstance = NetworkManager()
    
    let defaultManager: Alamofire.SessionManager = {
        let serverTrustPolicies: [String: ServerTrustPolicy] = [:]
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        
        return Alamofire.SessionManager (
            configuration: configuration,
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
    }()
}

class RequestManager : RequestManagerProtocol {
    func requestWithMethod<T:ResponseObject>(_ method: HTTPMethod, apiCall: String, params: [String: AnyObject], headers:[String: String], encoding: Alamofire.ParameterEncoding) -> Promise<T> {
        return Promise { seal in
            
        }
    }
}
