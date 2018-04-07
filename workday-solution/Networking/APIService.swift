//
//  APIService.swift
//  workday-solution
//
//  Created by Clinton Buie on 4/6/18.
//  Copyright © 2018 AmateMint. All rights reserved.
//

import UIKit
import PromiseKit
import Alamofire
import RealmSwift

// Inherit from Response Object to Return from Request
protocol ResponseObject {
}

extension Bool : ResponseObject {
}

extension Array : ResponseObject {
}

class APIService {
    
    static let sharedInstance = APIService()
    
    func ping() -> Promise<Bool> {
        
        let url = Strings.API.baseURL + "/" + Strings.API.Routes.health
    
        return firstly {
            Alamofire.request(url, method: .get).responseData()
            }.map {resp, data in
                if data.response?.statusCode == 200 {
                    return true
                } else {
                    return false
                }
        }

    }
    
    func getAllMedia() -> Promise<[String]> {
        return Promise { seal in
            
            
        }
    }
    
    func getMediaItem(_ item:String) -> Promise<MediaItem> {
        return Promise { seal in
            
        }
    }
}
