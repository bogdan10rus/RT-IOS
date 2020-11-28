//
//  Task.swift
//  TalkyFoxy
//
//  Created by Egor on 28.11.2020.
//

import Foundation

struct Task {
    let category: TaskCategory
    let titleRu: String
    let titleEn: String
    let descriptionRu: String
    let descriptionEn: String
    let text: String
    let answer: String?
    let id: Int
    
    init(from object: TaskObject) {
        category = TaskCategory(from: object.category)
        titleRu = object.titleRu
        titleEn = object.titleEn
        descriptionRu = object.descriptionRu
        descriptionEn = object.descriptionEn
        text = object.text
        answer = object.answer
        id = object.id
    }
}

struct TaskCategory {
    let titleRu: String
    let titleEn: String
    let descriptionRu: String
    let descriptionEn: String
    let id: Int
    
    init(from object: TaskCategoryObject) {
        titleRu = object.titleRu
        titleEn = object.titleEn
        descriptionRu = object.descriptionRu
        descriptionEn = object.descriptionEn
        id = object.id
    }
}
