//
//  PersonalCourse.swift
//  FreeFlashCards
//
//  Created by Vojtěch Kalivoda on 29.04.2023.
//

import Foundation

struct PersonalCourse: Codable, Identifiable {
    let courseId: String
    let courseName: String
    let courseCompleted: Bool
    // u can add other personal course stuff
    let lessons: [Lesson]
    
    var id: String? { courseId }
    
    // Convenience Init()
    init(
        courseId: String,
        courseName: String,
        courseCompleted: Bool,
        lessons: [Lesson]
    ) {
        self.courseId = courseId
        self.courseName = courseName
        self.courseCompleted = courseCompleted
        self.lessons = lessons
    }
    
    
    enum CodingKeys: String, CodingKey {
        case courseId = "course_id"
        case courseName = "course_name"
        case courseCompleted = "course_completed"
        case lessons = "lessons"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.courseId = try container.decode(String.self, forKey: .courseId)
        self.courseName = try container.decode(String.self, forKey: .courseName)
        self.courseCompleted = try container.decode(Bool.self, forKey: .courseCompleted)
        self.lessons = try container.decode([Lesson].self, forKey: .lessons)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.courseId, forKey: .courseId)
        try container.encode(self.courseName, forKey: .courseName)
        try container.encode(self.courseCompleted, forKey: .courseCompleted)
        try container.encode(self.lessons, forKey: .lessons)
    }
    
}
