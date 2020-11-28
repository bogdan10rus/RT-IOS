//
//  CallManager.swift
//  TalkyFoxy
//
//  Created by Богдан Марков on 28.11.2020.
//

import AVFoundation
import CallKit

class CallManager {
    private let callController = CXCallController()
    
    var answerHandler: (() -> Void)?
    var endHandler: (() -> Void)?
    var callid: UUID?
    
    func didAnswer(){
        answerHandler?()
    }
    
    func didEnd(){
        endHandler?()
    }
    
    func endCall() {
        guard let callId = callid else {
            print("Call not found")
            return
        }
      let endCallAction = CXEndCallAction(call: callId)
      let transaction = CXTransaction(action: endCallAction)
      
      requestTransaction(transaction)
    }
    
    private func requestTransaction(_ transaction: CXTransaction) {
      callController.request(transaction) { error in
        if let error = error {
          print("Error requesting transaction: \(error)")
        } else {
          print("Requested transaction successfully")
        }
      }
    }
}
