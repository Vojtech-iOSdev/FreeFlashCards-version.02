//
//  UserManager.swift
//  FreeFlashCards
//
//  Created by Vojtěch Kalivoda on 24.04.2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseSharedSwift


final class UserManager {
    
    static let shared = UserManager()
    
    private let usersCollection = Firestore.firestore().collection("users")
    
    private let encoder: Firebase = {
        let encoder = FirebaseDataEncoder
        encoder.keyen = .convertToSnakeCase
        return encoder
    }()
    
    private init() { }
    
    func userDocument(userID: String) -> DocumentReference {
        usersCollection.document(userID)
    }
     
    func createNewUser(dbUser: DBUser) async throws {
        try userDocument(userID: dbUser.userID).setData(from: dbUser, merge: false, encoder: encoder)
    }
    
    func createNewUser(authModel: AuthDataResultModel) async throws {
        var userData: [String: Any] = [
            "user_id" : authModel.uid,
            "is_anonymous" : authModel.isAnonymous,
            "date_created" : Timestamp(),
        ]
        
        if let email = authModel.email {
            userData["email"] = email
        }
        
        if let photoURL = authModel.photoURL {
            userData["photo_url"] = photoURL
        }
        
        try await userDocument(userID: authModel.uid).setData(userData, merge: false)
    }
    
    func getUser(userID: String) async throws -> DBUser {
        let snapshot = try await Firestore.firestore().collection("users").document(userID).getDocument()
        
        guard let data = snapshot.data(), let userID = data["user_id"] as? String else {
            throw URLError(.badServerResponse)
        }
        
        
        let isAnonymous = data["is_anonymous"] as? Bool
        let dateCreated = data["date_created"] as? Date
        let email = data["email"] as? String
        let photoURL = data["photo_url"] as? String
        
        return DBUser(userID: userID, isAnonymous: isAnonymous, dateCreated: dateCreated, email: email, photoURL: photoURL)
            }

}


