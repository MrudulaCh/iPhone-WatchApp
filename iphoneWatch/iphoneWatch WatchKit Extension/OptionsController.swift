//
//  OptionsController.swift
//  iphoneWatch WatchKit Extension
//
//  Created by Mrudula on 1/19/18.
//  Copyright © 2018 Mrudula. All rights reserved.
//

import Foundation
import WatchKit

class OptionsController: WKInterfaceController,URLSessionDelegate
{
    var oauthVal = ""
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        oauthVal = context as! String
        print("value inside watch app")
        print(oauthVal)
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func shopNow() {
        let url = URL(string: "https://50.193.56.106:9002/rest/v2/electronics/users/pradeep6923@gmail.com/orders2/shop")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "cartId=00000002&securityCode=123"
        request.httpBody = postString.data(using: .utf8)
        request.setValue(oauthVal, forHTTPHeaderField: "Authorization")
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue:OperationQueue.main)
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            guard let data = data, error == nil else {
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
               // print("response = \(response)")
            }
            
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            // print(json)
            let dict = json as? NSDictionary
            
            let codeVal = "\(dict!["code"]!)"
            self.presentController(withName: "page3", context: codeVal)
        })
        task.resume()
    }
    @IBAction func pickUp() {
       
        let url = URL(string: "https://50.193.56.106:9002/rest/v2/electronics/users/pradeep6923@gmail.com/orders2/pickup")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "cartId=00000002&securityCode=123"
        request.httpBody = postString.data(using: .utf8)
        request.setValue(oauthVal, forHTTPHeaderField: "Authorization")
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue:OperationQueue.main)
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            guard let data = data, error == nil else {
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                // print("response = \(response)")
            }
            
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            // print(json)
            let dict = json as? NSDictionary
            
            let codeVal = "\(dict!["code"]!)"
            self.presentController(withName: "page3", context: codeVal)
        })
        task.resume()
    }
    @IBAction func callMe() {
        let url = URL(string: "https://50.193.56.106:9002/rest/v2/electronics/users/pradeep6923@gmail.com/orders2/csr")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "cartId=00000002&securityCode=123"
        request.httpBody = postString.data(using: .utf8)
        request.setValue(oauthVal, forHTTPHeaderField: "Authorization")
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue:OperationQueue.main)
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            guard let data = data, error == nil else {
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                // print("response = \(response)")
            }
            
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            // print(json)
            let dict = json as? NSDictionary
            
            let codeVal = "\(dict!["code"]!)"
            self.presentController(withName: "page3", context: codeVal)
        })
        task.resume()
    }
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(URLSession.AuthChallengeDisposition.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!) )
    }
}
