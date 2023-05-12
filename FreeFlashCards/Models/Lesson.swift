//
//  Lesson.swift
//  FreeFlashCards
//
//  Created by Vojtěch Kalivoda on 29.04.2023.
//

import Foundation

struct Lesson: Codable, Identifiable {
    let name: String?
    let started: Bool?
    let completed: Bool?
    
    var id: String? { name }
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case started = "started"
        case completed = "completed"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.started = try container.decode(Bool.self, forKey: .started)
        self.completed = try container.decode(Bool.self, forKey: .completed)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.started, forKey: .started)
        try container.encode(self.completed, forKey: .completed)
    }

}

//struct Lesson2: Codable, Identifiable {
//    let lessonId: String
//    let lessonName: String
//    let lessonCompleted: Bool
////    let flashCards: [FLashCard]
//    
//    var id: String? { lessonId }
//    
//    
//    enum CodingKeys: String, CodingKey {
//        case lessonId = "lesson_id"
//        case lessonName = "lesson_name"
//        case lessonCompleted = "lesson_completed"
////        case flashCards = "flash_cards"
//    }
//    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.lessonId = try container.decode(String.self, forKey: .lessonId)
//        self.lessonName = try container.decode(String.self, forKey: .lessonName)
//        self.lessonCompleted = try container.decode(Bool.self, forKey: .lessonCompleted)
////        self.flashCards = try container.decode([FLashCard].self, forKey: .flashCards)
//    }
//    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(self.lessonId, forKey: .lessonId)
//        try container.encode(self.lessonName, forKey: .lessonName)
//        try container.encode(self.lessonCompleted, forKey: .lessonCompleted)
////        try container.encode(self.flashCards, forKey: .flashCards)
//    }
//    
//}
//

