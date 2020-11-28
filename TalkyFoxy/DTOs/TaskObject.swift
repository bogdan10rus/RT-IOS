//
//  TaskObject.swift
//  TalkyFoxy
//
//  Created by Egor on 28.11.2020.
//

import ObjectMapper

struct TaskObject: Mappable {
    var category: TaskCategoryObject!
    var titleRu: String!
    var titleEn: String!
    var descriptionRu: String!
    var descriptionEn: String!
    var text: String!
    var answer: String?
    var id: Int!
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        descriptionEn <- map["descriptionEn"]
        descriptionRu <- map["descriptionRu"]
        titleEn <- map["titleEn"]
        titleRu <- map["titleRu"]
        category <- map["category"]
        text <- map["text"]
        answer <- map["answer"]
    }
}

struct TaskCategoryObject: Mappable {
    var titleRu: String!
    var titleEn: String!
    var descriptionRu: String!
    var descriptionEn: String!
    var id: Int!
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        descriptionEn <- map["descriptionEn"]
        descriptionRu <- map["descriptionRu"]
        titleEn <- map["titleEn"]
        titleRu <- map["titleRu"]
    }
}
