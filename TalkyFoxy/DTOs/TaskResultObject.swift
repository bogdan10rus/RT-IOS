//
//  TaskResultObject.swift
//  TalkyFoxy
//
//  Created by Egor on 28.11.2020.
//

import ObjectMapper

struct TaskResultObject: Mappable {
    var taskId: Int!
    var taskTitleRu: String!
    var taskTitleEn: String!
    var taskRelevance: Int!
    var wordsPurity: Int!
    var vocabulary: Int!
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        taskId <- map["taskId"]
        taskTitleRu <- map["taskTitleRu"]
        taskTitleEn <- map["taskTitleEn"]
        taskRelevance <- map["taskRelevance"]
        wordsPurity <- map["wordsPurity"]
        vocabulary <- map["vocabulary"]
    }
}
