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
    
    func downloadMediaItems(_ items:[String], resultArray: [MediaItem], progressClosure:@escaping ProgressClosure) -> Promise<[MediaItem]> {
        var idArray = items
        guard let mediaId = idArray.popLast() else {
            // Array is empty, return the populated resultArray
            return Promise { seal in
                let progress:Float = Float(resultArray.count)/Float((idArray.count + resultArray.count))
                progressClosure(progress)
                seal.fulfill(resultArray)
            }
        }
        return APIService.sharedInstance.getMediaItem(mediaId).then { mediaItemArray -> Promise<[MediaItem]> in
            guard let item = mediaItemArray.id?.first else {
                return self.downloadMediaItems(idArray, resultArray: resultArray, progressClosure: progressClosure)
            }
            var arrayCopy = [MediaItem]()
            arrayCopy.append(contentsOf:resultArray)
            arrayCopy.append(item)
            let progress:Float = Float(arrayCopy.count)/Float((idArray.count + arrayCopy.count))
            progressClosure(progress)
            return self.downloadMediaItems(idArray, resultArray: arrayCopy, progressClosure: progressClosure)
        }
    }
}
