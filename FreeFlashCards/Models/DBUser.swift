//
//  DBUser.swift
//  FreeFlashCards
//
//  Created by Vojtěch Kalivoda on 24.04.2023.
//

import Foundation

struct DBUser: Codable {
    let userID: String
    let isAnonymous: Bool?
    let dateCreated: Date?
    let email: String?
    let photoURL: String?
}
