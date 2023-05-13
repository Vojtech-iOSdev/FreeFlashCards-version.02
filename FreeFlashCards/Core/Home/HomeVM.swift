//
//  HomeVM.swift
//  FreeFlashCards
//
//  Created by Vojtěch Kalivoda on 28.04.2023.
//

import Foundation

@MainActor
final class HomeVM: ObservableObject {
    
    @Injected(\.userManager) var userManager: UserManagerProtocol
    @Injected(\.authenticationManager) var authManager: AuthenticationManagerProtocol
    @Injected(\.coursesManager) var coursesManager: CoursesManagerProtocol
        
    @Published var showCourses: Bool = false
    @Published private(set) var courses: [Course]? = nil
    @Published var selectedCourse: Course? = nil
    @Published var lessons: [Lesson]? = nil
    
    @Published private var currentUser: AuthDataResultModel? = nil
    @Published private(set) var dbUser: DBUser? = nil


    init() {
        getCurrentUserId()
        Task {
            try await getUser()
        }
    }
        
    private func getCurrentUserId() {
        do {
            currentUser = try authManager.getAuthenticatedUser()
        } catch {
            print("DEBUG: error getting currentUser \(error)")
        }
    }
    
    func getCourses() async {
        do {
            courses = try await coursesManager.getCourses()
        } catch {
            // show alert: restart loading courses
            print("error getting coursesss: \(error)")
        }
    }
    
    func copyLessonsForStartedCourse() async throws {
        // WE NEED TO FUCKING CHANGE IT FREOM WITHIN THE FUNCTION OMFGGGG
        // set courseId from this user colection so it persists and then get it from firestore
        guard let uid = currentUser?.uid else { return }
        guard let currentCourseName = dbUser?.currentCourseName else { return }
        guard let currentCourseId = dbUser?.currentCourseId else { return }

        let lessons = try await coursesManager.getLessonsCollectionDocumentsInCoursesCollection(courseId: currentCourseId)
        
        // create course DONE(in func under) and lessons in his user colection
        for lesson in lessons {
            // create lessons in a new personalCourse document in UserManager !!!!!!!!
            try await userManager.createLessonsForPersonalCourse(userId: uid, courseName: currentCourseName, lesson: lesson)
        }
    }
    
    func getLessonsForStartedCourse() async throws {
        guard let uid = currentUser?.uid else { throw URLError(.badServerResponse) }
        guard let currentCourseName = dbUser?.currentCourseName else { throw URLError(.badURL) }
        
        let personalLessons = try await userManager.getLessonsForPersonalCourse(userId: uid, courseName: currentCourseName)
        self.lessons = personalLessons
        print("personal lessons print: \(personalLessons)")
    }
    
    func createPersonalCourseForUser() async throws {
        guard let uid = currentUser?.uid else { return }
        guard let currentCourseName = dbUser?.currentCourseName else { return }
        guard let currentCourseId = dbUser?.currentCourseId else { return }

        try await userManager.createPersonalCourse(userId: uid, courseId: currentCourseId, courseName: currentCourseName)
    }
    
    func updateCurrentCourseName(currentCourseName: String) async throws {
        guard let uid = currentUser?.uid else { return }
        
        try await userManager.updateCurrentCourseName(userId: uid, currentCourseName: currentCourseName)
    }
    
    func updateCurrentCourseId(currentCourseId: String) async throws {
        guard let uid = currentUser?.uid else { return }
        
        try await userManager.updateCurrentCourseId(userId: uid, currentCourseId: currentCourseId)
    }
    
    func getUser() async throws {
        guard let uid = currentUser?.uid else { return }
        
        dbUser = try await userManager.getUser(userID: uid)
    }
}

/*
 get all courses to select which one to Start DONE
 get all lessons for that course DONE
 create copy of this course and his lessons in his user colection DONE
 get the personal course with the lessons displayed DONE
 
 -> update values for started each course if its started or not so we know if we need to create all the folders or it already exists
 when he starts lessons we will get the lesson cards from the course lesson and put it to his own lesson... later we modify the lesson and the cards
 and during learning session we will get the cards with pagination by 5 and display it and and modify them
 */
