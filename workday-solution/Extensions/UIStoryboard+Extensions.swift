//
//  UIStoryboard+Extensions.swift
//  workday-solution
//
//  Created by Clinton Buie on 4/6/18.
//  Copyright © 2018 AmateMint. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    class func mainStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
}

extension UIStoryboard {
    class func mediaCollectionViewController() -> MediaCollectionViewController {
        return mainStoryboard().instantiateViewController(withIdentifier: String(describing:MediaCollectionViewController.self)) as! MediaCollectionViewController
    }
    
    class func mediaPlayerViewController() -> MediaPlayerViewController {
        return mainStoryboard().instantiateViewController(withIdentifier: String(describing:MediaPlayerViewController.self)) as! MediaPlayerViewController
    }
}
