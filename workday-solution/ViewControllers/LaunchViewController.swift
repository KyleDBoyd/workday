//
//  ViewController.swift
//  workday-solution
//
//  Created by Clinton Buie on 4/6/18.
//  Copyright © 2018 AmateMint. All rights reserved.
//

import UIKit
import GradientProgressBar

class LaunchViewController: UIViewController {

    @IBOutlet weak var launchLogo: UIImageView!
    @IBOutlet weak var progressBar: GradientProgressBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.launchLogo.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.showLaunchLogo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func showLaunchLogo() {
        self.launchLogo.alpha = 0.0
        self.launchLogo.isHidden = false
        self.progressBar.alpha = 0.0
        self.progressBar.isHidden = false
        
        UIView.animate(withDuration: 1.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.launchLogo.alpha = 1.0
            self.progressBar.alpha = 1.0
        }) { _ in
            self.loadMedia()
        }
    }
    
    private func hideLaunchLogo( _ viewModel:MediaItemVM) {
        UIView.animate(withDuration: 1.5, delay: 2.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.launchLogo.alpha = 0.0
            self.progressBar.alpha = 0.0
        }, completion: { (_) in
            let controller = MediaCollectionViewController.controller(viewModel)
            let appDelegate = AppDelegate.getAppDelegate().setRootViewController(controller)
        })
    }
    
    private func loadMedia() {
        let viewModel = MediaItemVM()
        viewModel.getMediaItems { progress in
            print(progress)
            self.progressBar.setProgress(progress, animated: true)
            if progress == 1.0 {
                self.hideLaunchLogo(viewModel)
            }
        }
    }
}

