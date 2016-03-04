//
//  HomeVC.swift
//  Skeju
//
//  Created by Hanbeen Kim on 3/3/16.
//  Copyright © 2016 GeorgiaTech. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var username: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let isLoggedIn:Int = prefs.integerForKey("ISLOGGEDIN") as Int
        if (isLoggedIn != 1) {
            self.performSegueWithIdentifier("to_login", sender: self)
        } else {
            self.username.text = prefs.valueForKey("USERNAME") as? String
        }
    }
    
    @IBAction func logoutClicked(sender: UIButton) {
        let appDomain = NSBundle.mainBundle().bundleIdentifier
        NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain!)
        self.performSegueWithIdentifier("to_login", sender: self)
    }
}
