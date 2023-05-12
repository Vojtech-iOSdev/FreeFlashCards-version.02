//
//  CoursesManager.swift
//  FreeFlashCards
//
//  Created by Vojtěch Kalivoda on 28.04.2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


final class CoursesManager: CoursesManagerProtocol {
    
    
    private let coursesCollection = Firestore.firestore().collection("courses")
        
    func getLessonsCollectionDocumentsInCoursesCollection(courseId: String) async throws -> [Lesson] {
        try await coursesCollection.document(courseId).collection("lessons").getDocuments(as: Lesson.self)
    }
    
    func getAllDocumentsWhereNameIsEqual() async throws -> [Course] {
        try await coursesCollection.whereField(Course.CodingKeys.courseName.stringValue,isEqualTo: "english_course")
            .getDocuments(as: Course.self)
    }
    
    func getCourses() async throws -> [Course] {
        try await coursesCollection.getDocuments(as: Course.self)
    }
    
    func testFunc() -> String {
        let text = "final text from Manager"
        return text
    }
    
    // not finished
//    func startCourse() async throws -> Course {
//        // get specific document by documentid !!! tomorrow
//        try await coursesCollection.document().getDocument(as: Course.self)
//    }
    
}
