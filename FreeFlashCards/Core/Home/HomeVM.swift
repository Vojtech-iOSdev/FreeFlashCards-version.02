//
//  HomeVM.swift
//  FreeFlashCards
//
//  Created by Vojtěch Kalivoda on 28.04.2023.
//

import Foundation

@MainActor
final class HomeVM: ObservableObject {
    
    let authManager = AuthenticationManager.shared
    let coursesManager = CoursesManager.shared
    let userManager: UserManager
    
    @Published var showCourses: Bool = false
    @Published private(set) var courses: [Course]? = nil
    @Published var selectedCourse: Course? = nil
    
    init(userManager: UserManager) {
        self.userManager = userManager
        
    }
    
    func getCourses() async {
        do {
            courses = try await coursesManager.getCourses()
        } catch {
            // show alert: restart loading courses
            print("error getting coursesss: \(error)")
        }
        
    }
    
    func createPersonalCourse(courseId: String) async {
        do {
            let authDataResult = try authManager.getAuthenticatedUser()
            try await userManager.createPersonalCourseModel(userId: authDataResult.uid, courseId: courseId)
        } catch {
            print("error creating personal course :/ \(error.localizedDescription)")
        }
    }
    
    func getPersonalCourseWithNewIdOfThePersonalCourse() {
        //
    }
    
    
    func testingCreatingDocs() {
        do {
            let authDataResult = try authManager.getAuthenticatedUser()
            let _ = userManager.userPersonalCourseDocument(userId: authDataResult.uid)
        } catch {
            print("stupidd erorrs\(error.localizedDescription)")
        }
        
    }
}