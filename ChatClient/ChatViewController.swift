//
//  ChatViewController.swift
//  ChatClient
//
//  Created by Jasen Salcido on 9/11/15.
//  Copyright (c) 2015 Jasen Salcido. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var messages: NSArray?

    var currentUser: PFUser?
    @IBOutlet weak var chatTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

        NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: "getMessagesOnTimer", userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSendButton(sender: AnyObject) {
        var chatMessage = PFObject(className: "Message")
        chatMessage.setObject(chatTextField.text, forKey: "text")
        chatMessage.setObject(currentUser!, forKey: "user")
        
        chatMessage.saveInBackgroundWithBlock { (succeeded: Bool, error: NSError?) -> Void in
            if(succeeded) {
                println("saved!")
            } else {
                println("couldnt save message")
            }
        }
        
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let messages = messages {
            return messages.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("MessageCell", forIndexPath: indexPath) as! MessageTableViewCell
        
        let message = messages![indexPath.row]
        
        cell.messageLabel.text = message["text"] as! String
        if message["user"] != nil {
            var user = message["user"]
            if user??.username != nil {
                cell.authorLabel.text = user??.username
            }
            
        }

        
        return cell
    }
    
    func getMessagesOnTimer() {
        var query = PFQuery(className:"Message")
        query.includeKey("user")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                println("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        println(object.objectId)
                    }
                    self.messages = objects
                }
                self.tableView.reloadData()
            } else {
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
