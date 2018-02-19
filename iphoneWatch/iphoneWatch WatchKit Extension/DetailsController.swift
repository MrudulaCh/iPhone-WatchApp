//
//  DetailsController.swift
//  iphoneWatch WatchKit Extension
//
//  Created by Mrudula on 1/21/18.
//  Copyright © 2018 Mrudula. All rights reserved.
//

import Foundation
import WatchKit

class DetailsController: WKInterfaceController,URLSessionDelegate
{
    @IBOutlet var orderCode: WKInterfaceLabel!
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        // Configure interface objects here.
        orderCode.setText(context as? String)
}
}
