//
//  PracticeVM.swift
//  FreeFlashCards
//
//  Created by Vojtěch Kalivoda on 30.04.2023.
//

import Foundation

@MainActor
final class PracticeVM: ObservableObject {
        
    @Injected(\.coursesManager) var coursesManager: CoursesManagerProtocol
    
    @Published private(set) var text: String = "noooo"
    @Published private(set) var courses: [Course]? = nil
    @Published private(set) var specificCourse: [Course]? = nil
    @Published private(set) var courseId: String = "no course id"
    @Published private(set) var lessons: [Lesson]? = nil


    func showText() {
        text = coursesManager.testFunc()
    }
    
    func getCourses() async throws {
        courses = try await coursesManager.getCourses()
    }
    
    func getSingleCourseByName() async throws {
        specificCourse = try await coursesManager.getAllDocumentsWhereNameIsEqual()
        guard let courseId = specificCourse?.first?.courseId else { return }
        self.courseId = courseId
    }
    
    func getSubCollectionDocs() async throws {
        lessons = try await coursesManager.getLessonsCollectionDocumentsInCoursesCollection(courseId: courseId)
    }
    
    func copyingSubColectionToUserColection() async {
        
    }
    
}
