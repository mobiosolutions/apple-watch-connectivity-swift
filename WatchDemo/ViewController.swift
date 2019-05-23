//
//  ViewController.swift
//  WatchDemo
//
//  Created by Harshad Pipaliya on 05/01/19.
//  Copyright © 2019 MobioSolutions. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController {
    
    //MARK: - Properties
    @IBOutlet weak var txtToWatch: UITextField!
    @IBOutlet weak var lblFromWatch: UILabel!
    
    var session: WCSession!
    
    //MARK: - UIViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if (WCSession.isSupported()) {
            session = WCSession.default
            session.delegate = self;
            session.activate()
        }
    }
    
    //MARK: - UIButton Action
    @IBAction func btnSendToWatchAction(_ sender: UIButton) {
        
        let messageToSend = ["Value": "Hello, "+txtToWatch.text!]
        session.sendMessage(messageToSend, replyHandler: { replyMessage in
            
        }, errorHandler: {error in
            print(error)
        })
    }
    
    
    
}

extension ViewController: WCSessionDelegate {
    
    //MARK: - WCSessionDelegate
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        let value = message["Value"] as? String
        DispatchQueue.main.async {
            self.lblFromWatch.text = value
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }
}
