//
//  MediaCollectionViewController.swift
//  workday-solution
//
//  Created by Clinton Buie on 4/6/18.
//  Copyright © 2018 AmateMint. All rights reserved.
//

import UIKit
import Player

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
        self.collectionView!.register(MediaCollectionViewCell.getNib(), forCellWithReuseIdentifier: String(describing: MediaCollectionViewCell.self))
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
        guard let urlString = item.url,
            let url = URL(string:urlString) else {
                return
        }
        let vc = MediaPlayerViewController.controller(url)
        self.present(vc, animated: true, completion: nil)
    }
}


extension MediaCollectionViewController : UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = self.view.bounds.width
        return CGSize(width: screenWidth, height: screenWidth)
    }
}
