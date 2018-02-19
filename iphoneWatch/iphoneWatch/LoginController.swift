//
//  LoginController.swift
//  iphoneWatch
//
//  Created by Mrudula on 1/16/18.
//  Copyright © 2018 Mrudula. All rights reserved.
//

import UIKit
import Foundation
import WatchConnectivity

class LoginController: UIViewController,URLSessionDelegate,WCSessionDelegate {
    
    @available(iOS 9.3, *)
    public func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    
    /** Called when the session can no longer be used to modify or add any new transfers and, all interactive messages will be cancelled, but delegate callbacks for background transfers can still occur. This will happen when the selected watch is being changed. */
    @available(iOS 9.3, *)
    public func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    
    /** Called when the session has completed activation. If session state is WCSessionActivationStateNotActivated there will be an error with more details. */
    @available(iOS 9.3, *)
    public func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
       
    }
    
    fileprivate var session: WCSession!
    
    var oauthToken = ""
    var accessToken = ""
    @IBOutlet weak var userText: UITextField!
    @IBOutlet weak var pwdText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if WCSession.isSupported() {
            session = WCSession.default
            session.delegate = self
            session.activate()
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
}
    
    @IBAction func userLogin(_ sender: Any) {
        
        let usernameVal:String = userText.text!
       // let passwordVal:String = pwdText.text!
       /* let grantType = "password"
        let clientId = "asm"
        let clientSecret = "test"
        let usernameVal:String = userText.text!
        let passwordVal:String = pwdText.text!
        
        var postParams = "grant_type=\(grantType)&"
        postParams += "client_id=\(clientId)&"
        postParams += "client_secret=\(clientSecret)&"
        postParams += "username=\(usernameVal)&"
        postParams += "password=\(passwordVal)"
        
        let postData = postParams.data(using: String.Encoding.utf8)
        let path = "https://50.193.56.106:9002/authorizationserver/oauth/token"
        let request = NSMutableURLRequest(url: NSURL(string: path)! as URL)
        request.httpMethod = "POST"
        request.httpBody = postData
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue:OperationQueue.main)
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
            print("status code value",statusCode)
            if(statusCode == 401){
                let alertController = UIAlertController(title: "Hello", message:
                    "Please check client credentials!!!", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
                
                self.present(alertController, animated: true, completion: nil)
            }else{
            let json = try? JSONSerialization.jsonObject(with: data!, options: [])
            print(json)
            let dict = json as? NSDictionary*/
        
        let grantType = "client_credentials"
        let clientId = "asm"
        let clientSecret = "test"
        
        var postParams = "grant_type=\(grantType)&"
        postParams += "client_id=\(clientId)&"
        postParams += "client_secret=\(clientSecret)"
        
        let postData = postParams.data(using: String.Encoding.utf8)
        let path = "https://50.193.56.106:9002/authorizationserver/oauth/token"
        let request = NSMutableURLRequest(url: NSURL(string: path)! as URL)
        request.httpMethod = "POST"
        request.httpBody = postData
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue:OperationQueue.main)
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
            print("status code value",statusCode)
            if(statusCode == 401){
                let alertController = UIAlertController(title: "Hello", message:
                    "Please check client credentials!!!", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
                
                self.present(alertController, animated: true, completion: nil)
            }else{
                let json = try? JSONSerialization.jsonObject(with: data!, options: [])
                 print(json)
                let dict = json as? NSDictionary
                
            
            let token:String = "\(dict!["access_token"]!)"
            let tokenType = "\(dict!["token_type"]!)"
            
            self.accessToken = tokenType+" "+token
            print(self.accessToken);
            if  token.isEmpty { return}
            else {
            let dashboardView = UIStoryboard(name: "Dashboard", bundle: nil).instantiateViewController(withIdentifier: "dashboardVC") as! UserDashboard
            
            dashboardView.textVal = usernameVal
            self.present(dashboardView, animated: false, completion: nil)
                self.sendMessage(tokenVal: self.accessToken)
            }
            }
        })
        task.resume()
    }

    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(URLSession.AuthChallengeDisposition.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!) )
    }
}

typealias WatchSessionProtocol = LoginController
extension WatchSessionProtocol {
    
    // WCSession Delegate protocol
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        
        // Reply handler, received message
        let value = message["Message"] as? String
        
        // GCD - Present on the screen
        DispatchQueue.main.async { () -> Void in
            //self.replyLabel.text = value!
        }
        
        // Send a reply
        replyHandler(["Message":"Hey Watch! Nice to meet you!\nWould you like work with me?"])
    }
}

typealias WatchSessionTasks = LoginController
extension WatchSessionTasks {
    
    // Method to send message to watchOS
    func sendMessage(tokenVal:String){
        // A dictionary of property list values that you want to send.
        let messageToSend = ["Message":tokenVal]
        
        // Task : Sends a message immediately to the counterpart and optionally delivers a response
        session.sendMessage(messageToSend, replyHandler: { (replyMessage) in
            // Reply handler - present the reply message on screen
            let value = replyMessage["Message"] as? String
            
            // GCD - Present on the screen
            DispatchQueue.main.async(execute: { () -> Void in
                // self.replyLabel.text = value!
            })
            
        }) { (error) in
            // Catch any error Handler
            print("error: \(error.localizedDescription)")
        }
    }
    
}

