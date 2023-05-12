//
//  UserManagerProtocol.swift
//  FreeFlashCards
//
//  Created by Vojtěch Kalivoda on 01.05.2023.
//

import Foundation
import FirebaseFirestore

protocol UserManagerProtocol {
    func userDocument(userID: String) -> DocumentReference
    func userPersonalCourseDocument(userId: String, courseName: String) -> DocumentReference
    func createPersonalCourse(userId: String, courseId: String, courseName: String) async throws
    func createLessonsForPersonalCourse(userId: String, courseName: String, lesson: Lesson) async throws
    func getLessonsForPersonalCourse(userId: String, courseName: String) async throws -> [Lesson]
    
    func updateCurrentCourseName(userId: String, currentCourseName: String) async throws
    func updateCurrentCourseId(userId: String, currentCourseId: String) async throws
    
    func getCourseWithId(courseId: String) async throws -> Course
    func getAllCourseLessonsWithId(courseId: String) async throws -> [Lesson]
    func createNewUser(dbUser: DBUser) async throws
    func getUser(userID: String) async throws -> DBUser
    func updateUserPremiumStatus(userID: String, isPremium: Bool) async throws
    func addUserPreference(userID: String, preference: String) async throws
    func removeUserPreference(userID: String, preference: String) async throws
}
