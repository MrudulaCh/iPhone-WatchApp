//
//  ViewController.swift
//  iphoneWatch
//
//  Created by Mrudula on 1/14/18.
//  Copyright © 2018 Mrudula. All rights reserved.
//

import UIKit
import Foundation
import WatchConnectivity

class ViewController: UIViewController,URLSessionDelegate,WCSessionDelegate {
    @available(iOS 9.3, *)
    public func sessionDidDeactivate(_ session: WCSession) {
        //..
    }
    
    
    /** Called when the session can no longer be used to modify or add any new transfers and, all interactive messages will be cancelled, but delegate callbacks for background transfers can still occur. This will happen when the selected watch is being changed. */
    @available(iOS 9.3, *)
    public func sessionDidBecomeInactive(_ session: WCSession) {
        //..
    }
    
    
    /** Called when the session has completed activation. If session state is WCSessionActivationStateNotActivated there will be an error with more details. */
    @available(iOS 9.3, *)
    public func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        //..
    }
    
    fileprivate var session: WCSession!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if WCSession.isSupported() {
            session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    var loginStatus:Bool = false
    @IBAction func Loginclick() {
        
        
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
                self.loginStatus = false
            }else{
            let json = try? JSONSerialization.jsonObject(with: data!, options: [])
           // print(json)
            let dict = json as? NSDictionary
            
            let token = "\(dict!["access_token"]!)"
            print(token);
            
            let loginView = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginController
            loginView.oauthToken = token
            self.present(loginView, animated: false, completion: nil)
           // self.sendMessage(tokenVal: token)
            }
        })
        task.resume()
    }
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(URLSession.AuthChallengeDisposition.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!) )
    }
    
    
}


    /*typealias PairedActions = ViewController
    extension PairedActions {
        
        // Send message to Apple Watch
        func sendToWatch(_ sender: AnyObject) {
            sendMessage()
        }
    }*/
    


