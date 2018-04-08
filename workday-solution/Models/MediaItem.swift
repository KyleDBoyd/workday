//
//  MediaItem.swift
//  workday-solution
//
//  Created by Clinton Buie on 4/6/18.
//  Copyright © 2018 AmateMint. All rights reserved.
//

import Foundation

struct MediaItemArray: Codable {
    var id:[MediaItem]?
}

struct MediaItem : Codable {
    var id:String?
    var name:String?
    var url:String?
    var quality:String?
    var duration:Double?
    
    init() {
        self.id = UUID.init().uuidString
        self.name = "Empty Item"
        self.url = Strings.API.baseURL
        self.quality = Strings.emptyString
        self.duration = 0
    }
}
