//
//  UserManager.swift
//  FreeFlashCards
//
//  Created by Vojtěch Kalivoda on 24.04.2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


final class UserManager {
    
    //static let shared = UserManager()
    
    private let coursesCollection = Firestore.firestore().collection("courses")
    private let usersCollection = Firestore.firestore().collection("users")
    
//    private init() { }
        
    /*
     private let userCollection: CollectionReference = Firestore.firestore().collection("users")
     
     private func userDocument(userId: String) -> DocumentReference {
         userCollection.document(userId)
     }
     
     private func userFavoriteProductCollection(userId: String) -> CollectionReference {
         userDocument(userId: userId).collection("favorite_products")
     }
     
     private func userFavoriteProductDocument(userId: String, favoriteProductId: String) -> DocumentReference {
         userFavoriteProductCollection(userId: userId).document(favoriteProductId)
     }
     */
    
//    private let encoder: Firestore.Encoder = {
//        let encoder = Firestore.Encoder()
////        encoder.keyEncodingStrategy = .convertToSnakeCase
//        return encoder
//    }()
//
//    private let decoder: Firestore.Decoder = {
//        let decoder = Firestore.Decoder()
////        decoder.keyDecodingStrategy = .convertFromSnakeCase
//        return decoder
//    }()
    
//    private var userFavoriteProductsListener: ListenerRegistration? = nil
    
    
    
    func userDocument(userID: String) -> DocumentReference {
        usersCollection.document(userID)
    }
    
    private func userPersonalCoursesCollection(userId: String) -> CollectionReference {
        userDocument(userID: userId).collection("personal_courses")
    }
    
    func userPersonalCourseDocument(userId: String) -> DocumentReference {
        userPersonalCoursesCollection(userId: userId).document() //.document(personalCourseId)
    }
    
    func createPersonalCourseModel(userId: String, courseId: String) async throws {
        // get the selected course from courses and setData as a new personal course which can be modified
        let course = try await getCourseWithId(courseId: courseId)
        
        // get lessons of the selectedCourse
        let courseLessons = try await getAllCourseLessonsWithId(courseId: courseId)
        
        // mirror course values to personalCourse!!
        let personalCourse = PersonalCourse(courseId: course.courseId,
                                            courseName: course.courseName,
                                            courseCompleted: false,
                                            lessons: courseLessons)
        
        
        try userPersonalCourseDocument(userId: userId).setData(from: personalCourse, merge: false)
    }
    
    func getCourseWithId(courseId: String) async throws -> Course {
        try await coursesCollection.document(courseId).getDocument(as: Course.self) //.getDocuments(as: Course.self)
    }
    
    func getAllCourseLessonsWithId(courseId: String) async throws -> [Lesson] {
        try await coursesCollection.document(courseId).collection("lessons").getDocuments(as: Lesson.self)
    }
    
    // Get flashcards for each lesson separetly
    func getFlashCardsForLesson() {
        
    }
         
    
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
