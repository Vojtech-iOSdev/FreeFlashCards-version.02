//
//  UserManager.swift
//  FreeFlashCards
//
//  Created by Vojtěch Kalivoda on 24.04.2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


final class UserManager: UserManagerProtocol {
        
    private let coursesCollection = Firestore.firestore().collection("courses")
    private let usersCollection = Firestore.firestore().collection("users")
        
    
    func getCourseWithId(courseId: String) async throws -> Course {
        try await coursesCollection.document(courseId).getDocument(as: Course.self) //.getDocuments(as: Course.self)
    }
    
    func getAllCourseLessonsWithId(courseId: String) async throws -> [Lesson] {
        try await coursesCollection.document(courseId).collection("lessons").getDocuments(as: Lesson.self)
    }
    
    func userDocument(userID: String) -> DocumentReference {
        usersCollection.document(userID)
    }
    
    private func userPersonalCoursesCollection(userId: String) -> CollectionReference {
        userDocument(userID: userId).collection("personal_courses")
    }
    
    func userPersonalCourseDocument(userId: String, courseName: String) -> DocumentReference {
        userPersonalCoursesCollection(userId: userId).document(courseName) //.document(personalCourseId)
    }
 
    func createPersonalCourse(userId: String, courseId: String, courseName: String) async throws {
        // get the selected course from courses and setData as a new personal course which can be modified
        let course = try await getCourseWithId(courseId: courseId)
        
        // get lessons of the selectedCourse
        let courseLessons = try await getAllCourseLessonsWithId(courseId: courseId)
        
        // mirror course values to personalCourse!!
        let personalCourse = PersonalCourse(courseId: course.courseId,
                                            courseName: course.courseName,
                                            courseCompleted: false,
                                            lessons: courseLessons)
        
        try await userPersonalCourseDocument(userId: userId, courseName: courseName).setData(from: personalCourse, merge: false)
    }
    
    func createLessonsForPersonalCourse(userId: String, courseName: String, lesson: Lesson) async throws {
        try await userPersonalCourseDocument(userId: userId, courseName: courseName).collection("lessons").addDocument(from: lesson)
    }
    
    func getLessonsForPersonalCourse(userId: String, courseName: String) async throws -> [Lesson] {
        try await userPersonalCoursesCollection(userId: userId).document(courseName).collection("lessons").getDocuments(as: Lesson.self)
    }
    
    func updateCurrentCourseName(userId: String, currentCourseName: String) async throws {
        let data: [String : Any] = [
            DBUser.CodingKeys.currentCourseName.rawValue : currentCourseName
            ]
        
        try await usersCollection.document(userId).updateData(data)
    }
    
    func updateCurrentCourseId(userId: String, currentCourseId: String) async throws {
        let data: [String : Any] = [
            DBUser.CodingKeys.currentCourseId.rawValue : currentCourseId
            ]
        
        try await usersCollection.document(userId).updateData(data)
    }
    
    func updateEnableNotifications(userId: String, enableNotifications: Bool) async throws {
        let data: [String : Any] = [
            DBUser.CodingKeys.enableNotifications.rawValue : enableNotifications
            ]
        
        try await usersCollection.document(userId).updateData(data)
    }
    
    func setCurrentDailyGoal(userId: String, selectedDailyGoal: Int) async throws {
        let data: [String : Any] = [
            DBUser.CodingKeys.dailyGoal.rawValue : selectedDailyGoal
            ]
        
        print(userId)
        print(data)
        try await userDocument(userID: userId).setData(data, merge: true)
    }
    
    func updateOnboardingCompleted(userId: String, onboardingCompleted: Bool) async throws {
        let data: [String : Any] = [
            DBUser.CodingKeys.onboardingCompleted.rawValue : onboardingCompleted
            ]
        
        try await usersCollection.document(userId).updateData(data)
    }
    
    // Get flashcards for each lesson separetly
//    func getFlashCardsForLesson() {
//
//    }
         
    
    func createNewUser(dbUser: DBUser) async throws {
        try userDocument(userID: dbUser.userId).setData(from: dbUser, merge: false)
    }
    
//    func createNewUser(authModel: AuthDataResultModel) async throws {
//        var userData: [String: Any] = [
//            "user_id" : authModel.uid,
//            "is_anonymous" : authModel.isAnonymous,
//            "date_created" : Timestamp(),
//        ]
//
//        if let email = authModel.email {
//            userData["email"] = email
//        }
//
//        if let photoURL = authModel.photoURL {
//            userData["photo_url"] = photoURL
//        }
//
//        try await userDocument(userID: authModel.uid).setData(userData, merge: false)
//    }
    
    func getUser(userID: String) async throws -> DBUser {
        try await userDocument(userID: userID).getDocument(as: DBUser.self)
        
//        guard let data = snapshot.data(), let userID = data["user_id"] as? String else {
//            throw URLError(.badServerResponse)
//        }
//
//        let isAnonymous = data["is_anonymous"] as? Bool
//        let dateCreated = data["date_created"] as? Date
//        let email = data["email"] as? String
//        let photoURL = data["photo_url"] as? String
//
//        return DBUser(userID: userID, isAnonymous: isAnonymous, dateCreated: dateCreated, email: email, photoURL: photoURL)
            }

    func updateUserPremiumStatus(userID: String, isPremium: Bool) async throws {
        let data: [String : Any] = [
            DBUser.CodingKeys.isPremium.rawValue : isPremium
            ]

        try await userDocument(userID: userID).updateData(data)
    }

    func addUserPreference(userID: String, preference: String) async throws {
        let data: [String : Any] = [
            DBUser.CodingKeys.preferences.rawValue : FieldValue.arrayUnion([preference])
            ]

        try await userDocument(userID: userID).updateData(data)
    }

    func removeUserPreference(userID: String, preference: String) async throws {
        let data: [String : Any] = [
            DBUser.CodingKeys.preferences.rawValue : FieldValue.arrayRemove([preference])
            ]

        try await userDocument(userID: userID).updateData(data)
    }
}
