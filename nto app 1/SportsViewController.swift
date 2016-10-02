//
//  SportsViewController.swift
//  NTO App 1
//
//  Created by Michael Zetune on 3/8/15.
//  Copyright (c) 2015 Michael Zetune. All rights reserved.
//

import UIKit

class SportsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAZA()
        // Do any additional setup after loading the view.
    }

    var AZASite = "http://www.teamsideline.com/Org/StandingsResults.aspx?d=IQHUKL5TfZqogyUxoybdC7XmzWH2FdyMU5%2B8xIXPdMmYv8SJDR02yXa%2Fe8zh2%2BfBvuqHQXLrcwQ%3D"
    
    var BBGSite = "http://www.teamsideline.com/Org/StandingsResults.aspx?d=IQHUKL5TfZqogyUxoybdC7XmzWH2FdyMU5%2b8xIXPdMnFqW%2b3Vg6pHlv1FewPl4agdm2gMIi0zwI%3d"
    
    
    @IBOutlet weak var webView: UIWebView!
    
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    func loadAZA() {
        
        let url = NSURL(string: AZASite)
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
    }
    
    func loadBBG() {
        
        let url = NSURL(string: BBGSite)
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
    }
    
    @IBAction func groupSelected(sender: AnyObject) {
    
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            loadAZA()
        case 1:
            loadBBG()
        default:
            break
    
    }
    
        
    

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    }
}
