//
//  Lesson.swift
//  FreeFlashCards
//
//  Created by Vojtěch Kalivoda on 29.04.2023.
//

import Foundation

struct Lesson: Codable, Identifiable {
    let lessonId: String
    let lessonName: String
    let lessonCompleted: Bool
    let flashCards: [FLashCard]
    
    var id: String? { lessonId }
    
    
    enum CodingKeys: String, CodingKey {
        case lessonId = "lesson_id"
        case lessonName = "lesson_name"
        case lessonCompleted = "lesson_completed"
        case flashCards = "flash_cards"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.lessonId = try container.decode(String.self, forKey: .lessonId)
        self.lessonName = try container.decode(String.self, forKey: .lessonName)
        self.lessonCompleted = try container.decode(Bool.self, forKey: .lessonCompleted)
        self.flashCards = try container.decode([FLashCard].self, forKey: .flashCards)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.lessonId, forKey: .lessonId)
        try container.encode(self.lessonName, forKey: .lessonName)
        try container.encode(self.lessonCompleted, forKey: .lessonCompleted)
        try container.encode(self.flashCards, forKey: .flashCards)
    }
    
}


