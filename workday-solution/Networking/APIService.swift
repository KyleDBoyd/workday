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

class APIService {
    
    static let sharedInstance = APIService()
    
    func ping() -> Promise<Bool> {
        let url = Strings.API.baseURL + "/" + Strings.API.Routes.health
        return Alamofire.request(url, method: .get).responseSuccess()
    }
    
    func getAllMedia() -> Promise<MediaItems> {
        let url = Strings.API.baseURL + "/" + Strings.API.Routes.media
        return Alamofire.request(url, method: .get).responseCodable()
    }
    
    func getMediaItem(_ item:String) -> Promise<MediaItemArray> {
        let url = Strings.API.baseURL + "/" + Strings.API.Routes.media + "/" + item
        return Alamofire.request(url, method: .get).responseCodable()
    }
    
    func downloadMediaItems(_ items:[String], resultArray: [MediaItem] ) -> Promise<[MediaItem]> {
        var idArray = items
        guard let mediaId = idArray.popLast() else {
            // Array is empty, return the populated resultArray
            return Promise { seal in
                seal.fulfill(resultArray)
            }
        }
        return APIService.sharedInstance.getMediaItem(mediaId).then { mediaItemArray -> Promise<[MediaItem]> in
            guard let item = mediaItemArray.id?.first else {
                return self.downloadMediaItems(idArray, resultArray: resultArray)
            }
            var arrayCopy = [MediaItem]()
            arrayCopy.append(contentsOf:resultArray)
            arrayCopy.append(item)
            return self.downloadMediaItems(idArray, resultArray: arrayCopy)
        }
    }
}
