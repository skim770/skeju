//
//  LoginVC.swift
//  Skeju
//
//  Created by Hanbeen Kim on 3/3/16.
//  Copyright © 2016 GeorgiaTech. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    @IBAction func loginClicked(sender: UIButton) {
        //check if credential is correct
        let username:NSString = self.username.text!
        let password:NSString = self.password.text!
        
        if ( username.isEqualToString("") || password.isEqualToString("") ) {
            //alert
        } else {
            NSLog("Login SUCCESS");
            
            let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
            prefs.setObject(username, forKey: "USERNAME")
            prefs.setInteger(1, forKey: "ISLOGGEDIN")
            prefs.synchronize()
            
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        //self.performSegueWithIdentifier("to_home", sender: self)
    }
}
