//
//  Message.swift
//  TalkyFoxy
//
//  Created by Egor on 28.11.2020.
//

import Foundation

struct Message {
    let sender: Sender
    let text: String
    
    init(sender: Sender, text: String) {
        self.sender = sender
        self.text = text
    }
}

enum Sender: Int {
    case bot
    case user
}
