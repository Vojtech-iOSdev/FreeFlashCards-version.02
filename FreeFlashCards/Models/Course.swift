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
    //let lessons: [Lesson]
    
    var id: String? { courseId }
    
    enum CodingKeys: String, CodingKey {
        case courseId = "course_id"
        case courseName = "course_name"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.courseId = try container.decode(String.self, forKey: .courseId)
        self.courseName = try container.decode(String.self, forKey: .courseName)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.courseId, forKey: .courseId)
        try container.encode(self.courseName, forKey: .courseName)
    }
    
//    static let dummyData: [Course] = [
//        Course
//    ]
    
}
