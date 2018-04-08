//
//  MediaCollectionViewController.swift
//  workday-solution
//
//  Created by Clinton Buie on 4/6/18.
//  Copyright © 2018 AmateMint. All rights reserved.
//

import UIKit
import Player
import PopupDialog

private let reuseIdentifier = "Cell"

class MediaCollectionViewController: UICollectionViewController {
    
    var viewModel:MediaItemVM!
    var objectPool:Pool<Player>!
    
    private class func controller() -> MediaCollectionViewController {
        let controller = UIStoryboard.mediaCollectionViewController()
        return controller
    }
    
    public class func controller(_ viewModel:MediaItemVM) -> MediaCollectionViewController {
        let controller = MediaCollectionViewController.controller()
        controller.viewModel = viewModel
        controller.objectPool = Pool<Player>(maxElementCount: 4, factory: {
            let player = Player()
            player.view.frame = controller.view.bounds
            return player
        })
        return controller
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerClasses()
        self.collectionView?.delegate = self
    }
    
    private func registerClasses() {
        // Register cell classes
        self.collectionView!.register(MediaCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: MediaCollectionViewCell.self))
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.mediaItems.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = self.viewModel.mediaItems[indexPath.item]
        let cell:MediaCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MediaCollectionViewCell.self), for: indexPath) as! MediaCollectionViewCell
        
            let player = Player()
            player.view.frame = cell.bounds
            cell.configure(item, player: player)
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let mediaCell = cell as! MediaCollectionViewCell
        mediaCell.clearCell()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = self.viewModel.mediaItems[indexPath.item]
        let player = self.setupPlayer(item: item)
        let videoViewController = self.setupVideoViewController(player)
        self.present(videoViewController, animated: true, completion: {
            player.playFromBeginning()
        })
    }
    
    private func setupPlayer( item:MediaItem) -> Player {
        let player = Player()
        guard let url = item.url,
            let videoUrl = URL(string: url) else {
                return player
        }
        player.autoplay = true
        player.playbackLoops = true
        player.view.frame = self.view.bounds
        player.url = videoUrl
        return player
    }
    
    private func setupVideoViewController(_ player:Player) -> PopupDialog {
        // Customize dialog appearance
        let pv = PopupDialogDefaultView.appearance()
        pv.titleFont    = UIFont(name: "HelveticaNeue-Light", size: 16)!
        pv.titleColor   = UIColor.white
        pv.messageFont  = UIFont(name: "HelveticaNeue", size: 14)!
        pv.messageColor = UIColor(white: 0.8, alpha: 1)
        
        // Customize the container view appearance
        let pcv = PopupDialogContainerView.appearance()
        pcv.backgroundColor = UIColor(red:0.23, green:0.23, blue:0.27, alpha:1.00)
        pcv.cornerRadius    = 2
        pcv.shadowEnabled   = true
        pcv.shadowColor     = UIColor.black
        
        // Customize overlay appearance
        let ov = PopupDialogOverlayView.appearance()
        ov.blurEnabled = true
        ov.blurRadius  = 30
        ov.liveBlurEnabled = true
        ov.opacity     = 0.7
        ov.color       = UIColor.black
        
        let popup = PopupDialog(viewController: player, buttonAlignment: UILayoutConstraintAxis.horizontal, transitionStyle: PopupDialogTransitionStyle.fadeIn, preferredWidth: self.view.frame.width, gestureDismissal: true, hideStatusBar: true, completion: nil)
        return popup
    }
}


extension MediaCollectionViewController : UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = self.view.bounds.width
        return CGSize(width: screenWidth, height: screenWidth)
    }
}
