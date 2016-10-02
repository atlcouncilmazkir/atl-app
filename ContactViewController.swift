//
//  ChaptersViewController.swift
//  NTO App 1
//
//  Created by Michael Zetune on 1/21/15.
//  Copyright (c) 2015 Michael Zetune. All rights reserved.
//

import UIKit
import MessageUI

class ContactViewController: UIViewController, UITableViewDelegate, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate {

    
    @IBOutlet weak var contactsTableView: UITableView!
    
    var personNum: Int = 0
    
    var contactsArray = ["Sherrie Stalarow", "Tracy Davis", "Max Harberg", "Nathan Levit", "Yoav Ilan", "Ryan Sukenik", "Max Feist", "Michael Zetune", "Pierce Bell", "Jessie Sureck", "Emily Mailman", "Sophie Pervere", "Shira Hovav", "Cammy Resnick", "Sarah Balis", "Maddie Weiner"]
    var descriptionArray = ["Senior Regional Director", "Regional Director", "Regional Godol", "S'gan", "Moreh", "Shaliach", "Mekasher", "Mazkir", "Gizbor", "Regional N'siah", "S'ganit", "MIT Mom", "Sh'licha", "Mekasheret", "Mazkirah", "Gizborit"]
    var emailArray = ["sstalarow@bbyo.org", "tdavis@bbyo.org", "ntogodol74@gmail.com", "ntosgan74@gmail.com", "ntomoreh74@gmail.com", "ntoshaliach74@gmail.com", "ntomekasher74@gmail.com","ntomazkir74@gmail.com", "ntogizbor74@gmail.com","ntonsiah74@gmail.com", "ntosganit74@gmail.com", "ntomitmom74@gmail.com", "ntoshlicha74@gmail.com", "ntomekasheret74@gmail.com", "ntomazkirah74@gmail.com", "ntogizborit74@gmail.com"]
    var phoneArray = ["", "", "972-555-5555", "972-555-5555", "972-555-5555", "972-555-5555", "972-555-5555", "972-555-5555", "972-555-5555", "972-555-5555", "972-555-5555", "972-555-5555", "972-555-5555", "972-555-5555", "972-555-5555", "972-555-5555"]
    
    // HEY YOU! UPDATE THIS NUMBER TO MATCH THE NUMBER OF DIRECTORS AT THE BEGINNING OF YOUR LIST OF PEOPLE THAT YOU DON'T WANT PHONE NUMBERS FOR. STILL FILL OUT "" FOR THE NUMBER LIKE IT IS ABOVE CURRENTLY:
    var numberOfDirectors = 2
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactsArray.count
    }
    
    func tableView(tableView: UITableViewDelegate, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = contactsTableView.dequeueReusableCellWithIdentifier("Cell1")! as UITableViewCell
        
        cell.textLabel!.text = contactsArray[indexPath.row]
        cell.detailTextLabel!.text = descriptionArray[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        personNum = indexPath.row
        
        let optionMenu = UIAlertController(title: nil, message: "Email or Text? Email only for directors.", preferredStyle: .ActionSheet)
        
        let emailAction = UIAlertAction(title: "Email", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.handleEmailRequest()
        })
        
        let textAction = UIAlertAction(title: "Text", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.handleTextRequest()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Cancelled")
        })
        
        optionMenu.addAction(emailAction)
        if personNum > numberOfDirectors - 1 {
            optionMenu.addAction(textAction) }
        optionMenu.addAction(cancelAction)
        
        self.presentViewController(optionMenu, animated: true, completion: nil)
        
    }
    
    
    func handleTextRequest() {
        
        let messageVC = MFMessageComposeViewController()
        
        messageVC.body = ""
        messageVC.recipients = ["\(phoneArray[personNum])"]
        messageVC.messageComposeDelegate = self
        
        self.presentViewController(messageVC, animated: true, completion: nil)
        
        
    }
    
    
    
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        //switch (result) {
        //case MessageComposeResultCancelled:
        //    print("Message was cancelled")
        //    self.dismissViewControllerAnimated(true, completion: nil)
        //case MessageComposeResultFailed:
        //    print("Message failed")
        //   self.dismissViewControllerAnimated(true, completion: nil)
        //case MessageComposeResultSent:
        //    print("Message was sent")
            self.dismissViewControllerAnimated(true, completion: nil)
        //default:
        //    break;
        //}
    }
    
    // MARK MFMailComposer Delegate
    
    func handleEmailRequest() {
        let mailComposeViewController = configuredMailComposeViewController()
        
        
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showMailErrorAlert()
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients([emailArray[personNum]])
        mailComposerVC.setSubject("Email to NTO \(descriptionArray[personNum])")
        mailComposerVC.setMessageBody("Hello,\n\n\n", isHTML: false)
        
        return mailComposerVC
    }
    func showMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
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
