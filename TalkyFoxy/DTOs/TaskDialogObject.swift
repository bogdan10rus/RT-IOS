//
//  TaskDialogObject.swift
//  TalkyFoxy
//
//  Created by Egor on 28.11.2020.
//

import ObjectMapper

struct TaskDialogObject: Mappable {
    var userId: Int!
    var taskId: Int!
    var messages: [TaskDialogMessageObject]!
    
    init?(map: Map) { }
    
    init(userId: Int, taskId: Int, messages: [Message]) {
        self.userId = userId
        self.taskId = taskId
        self.messages = messages.map { TaskDialogMessageObject(sender: $0.sender.rawValue, message: $0.text) }
    }
    
    mutating func mapping(map: Map) {
        taskId <- map["taskId"]
        userId <- map["userId"]
        messages <- map["messages"]
    }
}

struct TaskDialogMessageObject: Mappable {
    var sender: Int!
    var message: String!
    
    init?(map: Map) { }
    
    init(sender: Int, message: String) {
        self.sender = sender
        self.message = message
    }
    
    mutating func mapping(map: Map) {
        sender <- map["Sender"]
        message <- map["message"]
    }
}
