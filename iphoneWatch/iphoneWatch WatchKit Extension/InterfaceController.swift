//
//  InterfaceController.swift
//  iphoneWatch WatchKit Extension
//
//  Created by Mrudula on 1/14/18.
//  Copyright © 2018 Mrudula. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController,WCSessionDelegate {
    
    var accessTokenval = ""
    @IBOutlet var messageLabel: WKInterfaceLabel!
    public func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        //..code
    }
    
     var session : WCSession!
    //var counter = ""
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        if WCSession.isSupported() {
            session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func Imageclick() {
        if accessTokenval !=  "" {
            self.presentController(withName: "page2", context: accessTokenval)
        }else{
            let alertTitle = "Error!"
            let alertMessage = "Please login to iPhone app!!!"
            let action = [WKAlertAction(title:"OK",style: WKAlertActionStyle.default,handler:{print("Ok button tapped")})]
            self.presentAlert(withTitle: alertTitle, message: alertMessage, preferredStyle: .alert, actions: action)
            }
        }
}
    
   /* func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        let receivedGlobal =  applicationContext["counter"]
        print("receivedGlobal")
        print(receivedGlobal)
    }*/

    typealias WatchSessionProtocol = InterfaceController
    extension WatchSessionProtocol {
        
        // WCSession Delegate protocol
        func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
            
            // Reply handler, received message
            let value = message["Message"] as? String
            
            // GCD - Present on the screen
            DispatchQueue.main.async { () -> Void in
               // self.messageLabel.setText(value!)
                self.accessTokenval = value!
            }
            
            // Send a reply
            replyHandler(["Message":"Yes!\niOS 9.0 + WatchOS2 ..AAAAAAmazing!"])
            
        }
    }
    
    
    //MARK: - WatchSessionTasks -> InterfaceController
    typealias WatchSessionTasks = InterfaceController
    extension WatchSessionTasks {
        
        // Method to send message to paired iOS App (Parent)
        func sendMessage(){
            // A dictionary of property list values that you want to send.
            let messageToSend = ["Message":"Hey iPhone! I'm reachable!!!"]
            
            // Task : Sends a message immediately to the counterpart and optionally delivers a response
            session.sendMessage(messageToSend, replyHandler: { (replyMessage) in
                
                // Reply handler - present the reply message on screen
                let value = replyMessage["Message"] as? String
                
                // Set message label text with value
               // self.messageLabel.setText(value)
                
            }) { (error) in
                // Catch any error Handler
                print("error: \(error.localizedDescription)")
            }
        }
    }

