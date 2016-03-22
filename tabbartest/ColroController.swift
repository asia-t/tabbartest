//
//  ColroController.swift
//  tabbartest
//
//  Created by Joanna Turban on 14/03/16.
//  Copyright © 2016 team-hunch. All rights reserved.
//

import UIKit

class ColroController: UITabBarController, UITabBarControllerDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.delegate = self
    }
    
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        NSLog("Did select view controller:  \(self.viewControllers ?? nil)")
        NSLog("Num controllers: ", self.viewControllers!.count)
    }

}
