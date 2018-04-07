//
//  Alamofire+Extensions.swift
//  workday-solution
//
//  Created by Clinton Buie on 4/6/18.
//  Copyright © 2018 AmateMint. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit
import HTTPStatusCodes

extension Alamofire.DataRequest {
    // Return a Promise for a Codable
    public func responseCodable<T: Codable>() -> Promise<T> {
        
        return Promise { seal in
            responseData(queue: nil) { response in
                switch response.result {
                case .success(let value):
                    let decoder = JSONDecoder()
                    do {
                        seal.fulfill(try decoder.decode(T.self, from: value))
                    } catch let e {
                        seal.reject(e)
                    }
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
    
    public func responseSuccess() -> Promise<Bool> {
        return Promise { seal in
            responseData(queue: nil) { response in
                switch response.result {
                case .success(_):
                    guard let uSuccess = response.response?.statusCodeEnum.isSuccess else {
                        seal.fulfill(false)
                        return
                    }
                    if uSuccess {
                        seal.fulfill(true)
                    } else {
                        seal.fulfill(false)
                    }
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
}
