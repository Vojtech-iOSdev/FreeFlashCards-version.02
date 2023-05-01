//
//  UserManagerProtocol.swift
//  FreeFlashCards
//
//  Created by Vojtěch Kalivoda on 01.05.2023.
//

import Foundation
import FirebaseFirestore

protocol UserManagerProtocol {
    func testFunc() -> String
    func userDocument(userID: String) -> DocumentReference
    func userPersonalCourseDocument(userId: String) -> DocumentReference
    func createPersonalCourseModel(userId: String, courseId: String) async throws
    func getCourseWithId(courseId: String) async throws -> Course
    func getAllCourseLessonsWithId(courseId: String) async throws -> [Lesson]
    func createNewUser(dbUser: DBUser) async throws
    func getUser(userID: String) async throws -> DBUser
    func updateUserPremiumStatus(userID: String, isPremium: Bool) async throws
    func addUserPreference(userID: String, preference: String) async throws
    func removeUserPreference(userID: String, preference: String) async throws
}
