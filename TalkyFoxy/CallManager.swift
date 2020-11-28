//
//  CallManager.swift
//  TalkyFoxy
//
//  Created by Богдан Марков on 28.11.2020.
//

import Foundation
import CallKit

class CallManager {
    var answerHandler: (() -> Void)?
    var endHandler: (() -> Void)?
    
    func didAnswer(){
        answerHandler?()
    }
    
    func didEnd(){
        endHandler?()
    }
}
