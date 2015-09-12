//
//  ViewController.swift
//  ChatClient
//
//  Created by Jasen Salcido on 9/11/15.
//  Copyright (c) 2015 Jasen Salcido. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var currentUser: PFUser?
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        errorLabel.hidden = true
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onSignUp(sender: AnyObject) {
        errorLabel.hidden = true
        currentUser = PFUser()
        currentUser!.username = emailTextField.text
        currentUser!.email = emailTextField.text
        currentUser!.password = passwordTextField.text
        
        currentUser!.signUpInBackgroundWithBlock { (succeeded: Bool , error: NSError?) -> Void in
            if(error == nil){
                println("no error!")
                self.performSegueWithIdentifier("chatSegue", sender: self)
            } else {
                self.errorLabel.text = error?.userInfo?.description
                self.errorLabel.hidden = false
                
            }
        }
    }
    
    @IBAction func onSignIn(sender: AnyObject) {
        errorLabel.hidden = true
        currentUser = PFUser()
        PFUser.logInWithUsernameInBackground(emailTextField.text, password: passwordTextField.text) { (user:PFUser?, error: NSError?) -> Void in
            if(error == nil) {
                self.currentUser = user
                println("logged in!")
                self.performSegueWithIdentifier("chatSegue", sender: self)
            } else {
                self.errorLabel.text = error?.userInfo?.description
                self.errorLabel.hidden = false
            }            
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        var destinationController = segue.destinationViewController as! ChatViewController
        destinationController.currentUser = currentUser
    }
    

}

