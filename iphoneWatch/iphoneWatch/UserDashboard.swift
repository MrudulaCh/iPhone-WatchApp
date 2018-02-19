//
//  UserDashboard.swift
//  iphoneWatch
//
//  Created by Mrudula on 1/16/18.
//  Copyright © 2018 Mrudula. All rights reserved.
//

import Foundation
import UIKit
//import WatchConnectivity

class UserDashboard: UIViewController{
    
    var textVal = ""
    @IBOutlet weak var welcomeText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.welcomeText.text = "Welcome"+" "+textVal
       /* if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self as? WCSessionDelegate
            session.activate()
        }
        self.watchKitSetup()*/
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   /* func watchKitSetup() {
        if (WCSession.isSupported()) {
            let session = WCSession.default
            session.delegate = self as? WCSessionDelegate
            session.activate()
            
            let applicationData = ["counterValue":String(textVal)]
            
            // In your WatchKit extension, the value of this property is true when the paired iPhone is reachable via Bluetooth.
            // On iOS, the value is true when the paired Apple Watch is reachable via Bluetooth and the associated Watch app is running in the foreground.
            // In all other cases, the value is false.
           
                WCSession.default.sendMessage(applicationData, replyHandler: { (data) -> Void in
                    do {
                        try session.updateApplicationContext(["counter": "bar"])
                    } catch let error as NSError {
                        print(error.description)
                    }
                }) { (error) -> Void in
                    print("error: \(error.localizedDescription)")
                    
                }
            
        }
    }*/
}
