//
//  MediaItemViewModel.swift
//  workday-solution
//
//  Created by Clinton Buie on 4/6/18.
//  Copyright © 2018 AmateMint. All rights reserved.
//

import Foundation
import PromiseKit
import Cache

public typealias ProgressClosure = (Float) -> Void

class MediaItemVM {
    
    private(set) public var mediaItems:[MediaItem]
    
    init() {
        mediaItems = [MediaItem]()
    }
    
    public func getMediaItems(progressClosure:@escaping ProgressClosure) {
        let q = DispatchQueue.global(qos: .background)
        let mainQ = DispatchQueue.main
        firstly {
            APIService.sharedInstance.getAllMedia()
            }.then(on:q) { (items) -> Promise<[MediaItem]> in
                guard let mediaIds = items.media_items else {
                    return Promise { seal in
                        seal.fulfill([MediaItem]())
                    }
                }
                
                if try self.checkCache(items) {
                    return Promise { seal in
                        let result = try self.retrieveFromCache(items)
                        mainQ.async {
                            progressClosure(1.0)
                        }
                        seal.fulfill(result)
                    }
                } else {
                    return APIService.sharedInstance.downloadMediaItems(mediaIds, resultArray: [MediaItem](), progressClosure: progressClosure)
                }
            }.then { (result) -> Promise<[MediaItem]> in
                let items = MediaItems()
                try self.saveToCache(items, mediaItemArray: result)
                return self.sanitizeResults(result)
            }.done { (result) in
                self.mediaItems = result
            }.catch { (error) in
                // Handle All Errors that are thrown
        }
    }
    
    private func checkCache(_ mediaItems:MediaItems) throws -> Bool {
        let cache = try self.getCache()
        // Check if Exists
        let hasMediaItems = try cache.existsObject(ofType: [MediaItem].self, forKey: String(describing: MediaItems.self))
        
        return hasMediaItems
    }
    
    private func retrieveFromCache(_ mediaItems:MediaItems) throws -> [MediaItem] {
        let cache = try self.getCache()
        let result = try cache.object(ofType: [MediaItem].self, forKey: String(describing: MediaItems.self))
        return result
    }
    
    private func saveToCache(_ mediaItems:MediaItems, mediaItemArray:[MediaItem]) throws {
        let mediaItemsMirror = Mirror(reflecting: mediaItems)
        let cache = try self.getCache()
        try cache.setObject(mediaItemArray, forKey: String(describing: mediaItemsMirror.subjectType))
    }
    
    private func getCache() throws -> Storage {
        let diskConfig = DiskConfig(name: "Storage")
        let memoryConfig = MemoryConfig(expiry: .never, countLimit: 50, totalCostLimit: 50)
        let storage = try Storage(diskConfig: diskConfig, memoryConfig: memoryConfig)
        return storage
    }
    
    private func sanitizeResults(_ items:[MediaItem]) -> Promise<[MediaItem]> {
        return Promise { seal in
            let filterResults = self.filterDuplicateLinks(items)
            let finalResults = self.filterValidExtensions(filterResults)
            seal.fulfill(finalResults)
        }
    }
    
    private func filterDuplicateLinks(_ items:[MediaItem]) -> [MediaItem] {
        let mediaSet = NSMutableSet()
        let result = items.filter { (item) -> Bool in
            if !mediaSet.contains(item.url) {
                mediaSet.add(item.url)
                return true
            }
            return false
        }
        return result
    }
    
    private func filterValidExtensions(_ items:[MediaItem]) -> [MediaItem] {
        
        // Valid iOS Movie Extensions
        let movieExtensions = Set<String>(["mp4","mov","ts"])
        let result = items.filter { (item) -> Bool in
            guard let filePath = item.url?.components(separatedBy: "/").last else {
                return false
            }
            guard let fileExtension = filePath.components(separatedBy: ".").last?.localizedLowercase else {
                return false
            }
            return movieExtensions.contains(fileExtension)
        }
        return result
    }
}
