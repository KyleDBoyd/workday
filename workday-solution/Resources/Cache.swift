//
//  Cache.swift
//  workday-solution
//
//  Created by Clinton Buie on 4/8/18.
//  Copyright © 2018 AmateMint. All rights reserved.
//

import Foundation
import Cache

class Cache {
    
    private(set) var diskConfig:DiskConfig = DiskConfig(name: "Storage")
    private(set) var memoryConfig:MemoryConfig = MemoryConfig(expiry: .never, countLimit: 50, totalCostLimit: 50)
    static let sharedInstance = Cache()
    
    public func checkCache(_ mediaItems:MediaItems) throws -> Bool {
        let cache = try self.getCache()
        // Check if Exists
        let hasMediaItems = try cache.existsObject(ofType: [MediaItem].self, forKey: String(describing: MediaItems.self))
        
        return hasMediaItems
    }
    
    public func retrieveFromCache(_ mediaItems:MediaItems) throws -> [MediaItem] {
        let cache = try self.getCache()
        let result = try cache.object(ofType: [MediaItem].self, forKey: String(describing: MediaItems.self))
        return result
    }
    
    public func saveToCache(_ mediaItems:MediaItems, mediaItemArray:[MediaItem]) throws {
        let mediaItemsMirror = Mirror(reflecting: mediaItems)
        let cache = try self.getCache()
        try cache.setObject(mediaItemArray, forKey: String(describing: mediaItemsMirror.subjectType))
    }
    
    public func getCache() throws -> Storage {
        let storage = try Storage(diskConfig: diskConfig, memoryConfig: memoryConfig)
        return storage
    }
}
