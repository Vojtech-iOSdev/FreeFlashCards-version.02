//
//  DBUser.swift
//  FreeFlashCards
//
//  Created by Vojtěch Kalivoda on 24.04.2023.
//

import Foundation

struct DBUser: Codable, Equatable {
    let userId: String
    let isAnonymous: Bool?
    let email: String?
    let photoUrl: String?
    let dateCreated: Date?
    let isPremium: Bool?
    let preferences: [String]?
    let profileImagePath: String?
    let profileImagePathUrl: String?
    let currentCourseName: String?
    let currentCourseId: String?
    let onboardingCompleted: Bool
    
    init(auth: AuthDataResultModel) {
        self.userId = auth.uid
        self.isAnonymous = auth.isAnonymous
        self.email = auth.email
        self.photoUrl = auth.photoUrl
        self.dateCreated = Date()
        self.isPremium = false
        self.preferences = nil
        self.profileImagePath = nil
        self.profileImagePathUrl = nil
        self.currentCourseName = nil
        self.currentCourseId = nil
        self.onboardingCompleted = false

    }
    
    init(
        userId: String,
        isAnonymous: Bool? = nil,
        email: String? = nil,
        photoUrl: String? = nil,
        dateCreated: Date? = nil,
        isPremium: Bool? = nil,
        preferences: [String]? = nil,
        profileImagePath: String? = nil,
        profileImagePathUrl: String? = nil,
        currentCourseName: String? = nil,
        currentCourseId: String? = nil,
        onboardingCompleted: Bool = false
    ) {
        self.userId = userId
        self.isAnonymous = isAnonymous
        self.email = email
        self.photoUrl = photoUrl
        self.dateCreated = dateCreated
        self.isPremium = isPremium
        self.preferences = preferences
        self.profileImagePath = profileImagePath
        self.profileImagePathUrl = profileImagePathUrl
        self.currentCourseName = currentCourseName
        self.currentCourseId = currentCourseId
        self.onboardingCompleted = onboardingCompleted
    }
    
    //    func togglePremiumStatus() -> DBUser {
    //        let currentValue = isPremium ?? false
    //        return DBUser(
    //            userId: userId,
    //            isAnonymous: isAnonymous,
    //            email: email,
    //            photoUrl: photoUrl,
    //            dateCreated: dateCreated,
    //            isPremium: !currentValue)
    //    }
    
    //    mutating func togglePremiumStatus() {
    //        let currentValue = isPremium ?? false
    //        isPremium = !currentValue
    //    }
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case isAnonymous = "is_anonymous"
        case email = "email"
        case photoUrl = "photo_url"
        case dateCreated = "date_created"
        case isPremium = "user_isPremium"
        case preferences = "preferences"
        case favoriteMovie = "favorite_movie"
        case profileImagePath = "profile_image_path"
        case profileImagePathUrl = "profile_image_path_url"
        case currentCourseName = "current_course_name"
        case currentCourseId = "current_course_id"
        case onboardingCompleted = "onboarding_completed"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.isAnonymous = try container.decodeIfPresent(Bool.self, forKey: .isAnonymous)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.photoUrl = try container.decodeIfPresent(String.self, forKey: .photoUrl)
        self.dateCreated = try container.decodeIfPresent(Date.self, forKey: .dateCreated)
        self.isPremium = try container.decodeIfPresent(Bool.self, forKey: .isPremium)
        self.preferences = try container.decodeIfPresent([String].self, forKey: .preferences)
        self.profileImagePath = try container.decodeIfPresent(String.self, forKey: .profileImagePath)
        self.profileImagePathUrl = try container.decodeIfPresent(String.self, forKey: .profileImagePathUrl)
        self.currentCourseName = try container.decodeIfPresent(String.self, forKey: .currentCourseName)
        self.currentCourseId = try container.decodeIfPresent(String.self, forKey: .currentCourseId)
        self.onboardingCompleted = try container.decode(Bool.self, forKey: .onboardingCompleted)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.userId, forKey: .userId)
        try container.encodeIfPresent(self.isAnonymous, forKey: .isAnonymous)
        try container.encodeIfPresent(self.email, forKey: .email)
        try container.encodeIfPresent(self.photoUrl, forKey: .photoUrl)
        try container.encodeIfPresent(self.dateCreated, forKey: .dateCreated)
        try container.encodeIfPresent(self.isPremium, forKey: .isPremium)
        try container.encodeIfPresent(self.preferences, forKey: .preferences)
        try container.encodeIfPresent(self.profileImagePath, forKey: .profileImagePath)
        try container.encodeIfPresent(self.profileImagePathUrl, forKey: .profileImagePathUrl)
        try container.encodeIfPresent(self.currentCourseName, forKey: .currentCourseName)
        try container.encodeIfPresent(self.currentCourseId, forKey: .currentCourseId)
        try container.encodeIfPresent(self.onboardingCompleted, forKey: .onboardingCompleted)

    }
    
    static func ==(lhs: DBUser, rhs: DBUser) -> Bool {
        return lhs.userId == rhs.userId
    }
    
}
//
//struct DBUser: Codable {
//    let userID: String
//    let isAnonymous: Bool?
//    let dateCreated: Date?
//    let email: String?
//    let photoURL: String?
//    let isPremium: Bool?
//    let preferences: [String]?
//    let favouriteMovie: Movie?
//    
//    init(auth: AuthDataResultModel) {
//        self.userID = auth.uid
//        self.isAnonymous = auth.isAnonymous
//        self.email = auth.email
//        self.photoURL = auth.photoURL
//        self.dateCreated = Date()
//        self.isPremium = false
//        self.preferences = nil
//        self.favouriteMovie = nil
//    }
//    
//    init(
//        userID: String,
//        isAnonymous: Bool? = nil,
//        dateCreated: Date? = nil,
//        email: String? = nil,
//        photoURL: String? = nil,
//        isPremium: Bool? = nil,
//        preferences: [String]? = nil,
//        favouriteMovie: Movie? = nil
//    ) {
//        self.userID = userID
//        self.isAnonymous = isAnonymous
//        self.email = email
//        self.photoURL = photoURL
//        self.dateCreated = dateCreated
//        self.isPremium = isPremium
//        self.preferences = preferences
//        self.favouriteMovie = favouriteMovie
//    }
//    
////    func togglePremiumStatus() -> DBUser {
////        let currentPremiumStatus = isPremium ?? false
////        return DBUser(
////            userID: userID,
////            isAnonymous: isAnonymous,
////            dateCreated: dateCreated,
////            email: email,
////            photoURL: photoURL,
////            isPremium: !currentPremiumStatus)
////    }
//    
////    mutating func togglePremiumStatus() {
////        let currentPremiumStatus = isPremium ?? false
////        isPremium = !currentPremiumStatus
////    }
//    
//    
//    enum CodingKeys: String, CodingKey {
//        case userID = "user_id"
//        case isAnonymous = "is_anonymous"
//        case dateCreated = "date_created"
//        case email = "email"
//        case photoURL = "photo_url"
//        case isPremium = "user_isPremium"
//        case preferences = "preferences"
//        case favouriteMovie = "favourite_movie"
//    }
//    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.userID = try container.decode(String.self, forKey: .userID)
//        self.isAnonymous = try container.decodeIfPresent(Bool.self, forKey: .isAnonymous)
//        self.dateCreated = try container.decodeIfPresent(Date.self, forKey: .dateCreated)
//        self.email = try container.decodeIfPresent(String.self, forKey: .email)
//        self.photoURL = try container.decodeIfPresent(String.self, forKey: .photoURL)
//        self.isPremium = try container.decodeIfPresent(Bool.self, forKey: .isPremium)
//        self.preferences = try container.decodeIfPresent([String].self, forKey: .preferences)
//        self.favouriteMovie = try container.decodeIfPresent(Movie.self, forKey: .favouriteMovie)
//    }
//    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(self.userID, forKey: .userID)
//        try container.encodeIfPresent(self.isAnonymous, forKey: .isAnonymous)
//        try container.encodeIfPresent(self.dateCreated, forKey: .dateCreated)
//        try container.encodeIfPresent(self.email, forKey: .email)
//        try container.encodeIfPresent(self.photoURL, forKey: .photoURL)
//        try container.encodeIfPresent(self.isPremium, forKey: .isPremium)
//        try container.encodeIfPresent(self.preferences, forKey: .preferences)
//        try container.encodeIfPresent(self.favouriteMovie, forKey: .favouriteMovie)
//    }
//    
//}
