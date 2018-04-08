//
//  MediaCollectionViewCell.swift
//  workday-solution
//
//  Created by Clinton Buie on 4/6/18.
//  Copyright © 2018 AmateMint. All rights reserved.
//

import UIKit
import Player

class MediaCollectionViewCell: UICollectionViewCell {
    
    var item:MediaItem?
    var player:Player?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(_ item:MediaItem, player:Player) {
        self.item = item
        self.player = player
        guard let url = item.url,
            let videoUrl = URL(string: url) else {
                return
        }
        self.player?.autoplay = true
        self.player?.view.frame = self.bounds
        
        self.addSubview(player.view)
        
        self.player?.url = videoUrl
        self.player?.playFromBeginning()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.item = nil
        self.player = nil
    }
}
