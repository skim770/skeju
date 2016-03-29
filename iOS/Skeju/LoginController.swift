//
//  LoginController.swift
//  Skeju
//
//  Created by Sung Kim on 3/6/16.
//  Copyright © 2016 GeorgiaTech. All rights reserved.
//

import Foundation
import UIKit
import FBSDKLoginKit

class LoginController: UIViewController, UITextFieldDelegate {
    @IBOutlet var loginView: UIView!
    @IBOutlet var usernameTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    @IBOutlet var loginBtn: UIButton!
    @IBOutlet var fbLoginBtn: UIButton!
    
    let userDefault = NSUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    func initUI() {
        loginView.layer.cornerRadius = 10
        loginView.layer.shadowColor = UIColor.blackColor().CGColor
        loginView.layer.shadowRadius = 5
        loginView.layer.shadowOpacity = 1
        loginView.layer.shadowOffset = CGSizeMake(2, 3)
        loginBtn.layer.cornerRadius = 4
        fbLoginBtn.layer.cornerRadius = 4
        usernameTF.delegate = self
        passwordTF.delegate = self
    }
    
    @IBAction func loginBtnTouchUpInside(sender: AnyObject) {
        print("Login Button Pressed.")
    }
    
    @IBAction func fbLoginBtnTouchUpInside(sender: AnyObject) {
        let fbLoginManager = FBSDKLoginManager()
        fbLoginManager.logInWithReadPermissions(["public_profile", "email", "user_friends"], fromViewController: self, handler: { (result, error) -> Void in
            if (error != nil) {
                NSLog("Error: \(error)")
            } else if (result.isCancelled) {
                NSLog("Process cancelled")
            } else {
                if FBSDKAccessToken.currentAccessToken() != nil {
                    let fbGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
                    fbGraphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
                        if (error) != nil {
                            print("Error: \(error)")
                        } else {
                            self.userDefault.setValue(result.valueForKey("name"), forKey: "FBName")
                            self.userDefault.setValue(result.valueForKey("id"), forKey: "FBID")
                        }
                    })
                }
                let mainVC = self.storyboard?.instantiateViewControllerWithIdentifier("MainVC") as! TabBarController
                self.presentViewController(mainVC, animated: true, completion: nil)
            }
        })
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        let nextTag: NSInteger! = textField.tag + 1
        let nextResponder: UIResponder! = textField.superview?.viewWithTag(nextTag)
        if nextResponder != nil {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
}