//
//  InterfaceController.swift
//  Watch Extension
//
//  Created by Harshad Pipaliya on 05/01/19.
//  Copyright © 2019 MobioSolutions. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController, WCSessionDelegate {
    
    //MARK: - Properties
    @IBOutlet weak var lblMsg: WKInterfaceLabel!
    var strMSG = String()
    var session: WCSession!
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }
    
    override func willActivate() {
        super.willActivate()
        if (WCSession.isSupported()) {
            session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }

    @IBAction func btnToPhoneAction() {
        let messageToSend = ["Value":"Hi, "+self.strMSG]
        session.sendMessage(messageToSend, replyHandler: { replyMessage in
        }, errorHandler: {error in
            print(error.localizedDescription)
        })
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        let value = message["Value"] as? String
        DispatchQueue.main.async {
            self.lblMsg.setText(value)
            self.strMSG = value ?? ""
        }
    }
}
