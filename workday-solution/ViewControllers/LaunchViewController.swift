//
//  ViewController.swift
//  workday-solution
//
//  Created by Clinton Buie on 4/6/18.
//  Copyright © 2018 AmateMint. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {

    @IBOutlet weak var launchLogo: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.launchLogo.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.animateLaunchLogo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func animateLaunchLogo() {
        self.launchLogo.alpha = 0.0
        self.launchLogo.isHidden = false
        
        UIView.animate(withDuration: 1.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.launchLogo.alpha = 1.0
        }) { _ in
            UIView.animate(withDuration: 1.5, delay: 2.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.launchLogo.alpha = 0.0
            }, completion: { (_) in
                self.testAPI()
            })
        }
    }
    
    private func testAPI() {
        let viewModel = MediaItemVM()
        viewModel.getMediaItems()
    }
}

