//
//  TaskResult.swift
//  TalkyFoxy
//
//  Created by Egor on 28.11.2020.
//

import Foundation

struct TaskResult {
    let taskId: Int
    let taskTitleRu: String
    let taskTitleEn: String
    let taskRelevance: Int
    let wordsPurity: Int
    let vocabulary: Int
    
    init(from object: TaskResultObject) {
        taskId = object.taskId
        taskTitleRu = object.taskTitleRu
        taskTitleEn = object.taskTitleEn
        taskRelevance = object.taskRelevance
        wordsPurity = object.wordsPurity
        vocabulary = object.vocabulary
    }
}
