//
//  FLashCard.swift
//  FreeFlashCards
//
//  Created by Vojtěch Kalivoda on 29.04.2023.
//

import Foundation


struct FLashCard: Codable, Identifiable {
    let flashCardId: String
    let word: String
    let translation: String
    
    var id: String? { flashCardId }
    
    
    enum CodingKeys: String, CodingKey {
        case flashCardId = "flash_card_id"
        case word = "word"
        case translation = "translation"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.flashCardId = try container.decode(String.self, forKey: .flashCardId)
        self.word = try container.decode(String.self, forKey: .word)
        self.translation = try container.decode(String.self, forKey: .translation)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.flashCardId, forKey: .flashCardId)
        try container.encode(self.word, forKey: .word)
        try container.encode(self.translation, forKey: .translation)
    }
}
