//
//  Course.swift
//  FreeFlashCards
//
//  Created by Vojtěch Kalivoda on 28.04.2023.
//

import Foundation

struct Course: Codable, Identifiable {
    let courseId: String
    let courseName: String
    let courseCompleted: Bool?
    let stringArray: [String]?
    
    var id: String? { courseId }
    
    enum CodingKeys: String, CodingKey {
        case courseId = "course_id"
        case courseName = "course_name"
        case courseCompleted = "course_completed"
        case stringArray = "string_array"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.courseId = try container.decode(String.self, forKey: .courseId)
        self.courseName = try container.decode(String.self, forKey: .courseName)
        self.courseCompleted = try container.decode(Bool.self, forKey: .courseCompleted)
        self.stringArray = try container.decode([String].self, forKey: .stringArray)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.courseId, forKey: .courseId)
        try container.encode(self.courseName, forKey: .courseName)
        try container.encode(self.courseCompleted, forKey: .courseCompleted)
        try container.encode(self.stringArray, forKey: .stringArray)
    }
    
    // Convenience Init()
    init(
        courseId: String,
        courseName: String,
        courseCompleted: Bool,
        stringArray: [String]
    ) {
        self.courseId = courseId
        self.courseName = courseName
        self.courseCompleted = courseCompleted
        self.stringArray = stringArray
    }
    
//    static let dummyData: [Course] = [
//        Course
//    ]
    
}
