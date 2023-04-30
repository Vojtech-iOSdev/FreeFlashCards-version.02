//
//  CoursesManager.swift
//  FreeFlashCards
//
//  Created by Vojtěch Kalivoda on 28.04.2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


final class CoursesManager {
    
    
    
    private let coursesCollection = Firestore.firestore().collection("courses")
    
    static let shared = CoursesManager()
    private init() { }
    
    
    func getCourses() async throws -> [Course] {
        try await coursesCollection.getDocuments(as: Course.self)
    }
    
    // not finished
    func startCourse() async throws -> Course {
        // get specific document by documentid !!! tomorrow
        try await coursesCollection.document().getDocument(as: Course.self)
    }
    
}
