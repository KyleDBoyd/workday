//
//  MediaPlayerViewController.swift
//  workday-solution
//
//  Created by Clinton Buie on 4/6/18.
//  Copyright © 2018 AmateMint. All rights reserved.
//

import UIKit
import Player

class MediaPlayerViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    var url:URL!
    var player:Player!
    
    private class func controller() -> MediaPlayerViewController {
        let controller = UIStoryboard.mediaPlayerViewController()
        return controller
    }
    
    class func controller(_ url:URL) -> MediaPlayerViewController  {
        let controller = MediaPlayerViewController.controller()
        controller.url = url
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupGestureRecognizers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupPlayer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func setupGestureRecognizers() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(MediaPlayerViewController.handleTap))
        tapGesture.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapGesture)
    }
    
    private func setupPlayer() {
        let player = Player()
        self.player = player
        player.autoplay = true
        player.playbackLoops = true
        player.view.frame = self.containerView.bounds
        player.url = self.url
        self.containerView.addSubview(player.view)
        self.player.playFromBeginning()
        self.view.backgroundColor = UIColor.white
    }
    
    @objc func handleTap(recognizer: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
}
