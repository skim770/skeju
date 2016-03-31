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
                            let fname = result.valueForKey("name")
                            let fid = result.valueForKey("id")
                            self.userDefault.setValue(fname, forKey: "FBName")
                            self.userDefault.setValue(fid, forKey: "FBID")
                            
                            let request = NSMutableURLRequest(URL: NSURL(string: "http://api-skeju.rhcloud.com/user")!)
                            request.HTTPMethod = "POST"
                            let postString = "id=\(fname as! String)&fbId=\(fid as! String)"
                            request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
                            let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
                                guard error == nil && data != nil else {                                                          // check for fundamental networking error
                                    print("error=\(error)")
                                    return
                                }
                                
                                if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                                    print("response = \(response)")
                                }
                                
                                let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                                print("responseString = \(responseString)")
                            }
                            task.resume()
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