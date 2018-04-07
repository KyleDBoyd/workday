//
//  MediaCollectionViewController.swift
//  workday-solution
//
//  Created by Clinton Buie on 4/6/18.
//  Copyright © 2018 AmateMint. All rights reserved.
//

import UIKit
import Pooling

private let reuseIdentifier = "Cell"

class MediaCollectionViewController: UICollectionViewController {
    
    var viewModel:MediaItemVM!
    
    private class func controller() -> MediaCollectionViewController {
        let controller = UIStoryboard.mediaCollectionViewController()
        return controller
    }
    
    public class func controller(_ viewModel:MediaItemVM) -> MediaCollectionViewController {
        let controller = MediaCollectionViewController.controller()
        controller.viewModel = viewModel
        return controller
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerClasses()
    }
    
    private func registerClasses() {
        // Register cell classes
        self.collectionView!.register(MediaCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: MediaCollectionViewCell.self))
    }
    
    private func setupObjectPool() {
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
        cell.configure(item)
    
        return cell
    }
}
