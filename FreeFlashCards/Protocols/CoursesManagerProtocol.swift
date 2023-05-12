//
//  CoursesManagerProtocol.swift
//  FreeFlashCards
//
//  Created by Vojtěch Kalivoda on 01.05.2023.
//

import Foundation

protocol CoursesManagerProtocol {
    func testFunc() -> String
    func getCourses() async throws -> [Course]
    func getAllDocumentsWhereNameIsEqual() async throws -> [Course]
    func getLessonsCollectionDocumentsInCoursesCollection(courseId: String) async throws -> [Lesson]
}


