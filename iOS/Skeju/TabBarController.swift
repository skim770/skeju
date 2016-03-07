//
//  TabBarController.swift
//  Skeju
//
//  Created by 김성식 on 3/7/16.
//  Copyright © 2016 GeorgiaTech. All rights reserved.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let color = UIColor(red: 22/255.0, green: 22/255.0, blue: 22/255.0, alpha: 1.0)
        UITabBar.appearance().barTintColor = color
        UITabBar.appearance().tintColor = UIColor.whiteColor()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
}