//
//  OnboardingVM.swift
//  FreeFlashCards
//
//  Created by Vojtěch Kalivoda on 22.04.2023.
//

import Foundation
import AuthenticationServices

@MainActor
final class OnboardingVM: ObservableObject {
    
    func signInGoogle() async throws {
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        let authModel = try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
        try await UserManager.shared.createNewUser(authModel: authModel)
    }
    
    func signInApple() async throws {
        let helper = SignInAppleHelper()
        let tokens = try await helper.startSignInWithAppleFlow()
        let authModel = try await AuthenticationManager.shared.signInWithApple(tokens: tokens)
        try await UserManager.shared.createNewUser(authModel: authModel)
    }
    
    func signInAnonymously() async throws {
        let authModel = try await AuthenticationManager.shared.signInAnonymously()
        let dbUser = DBUser(userID: authModel.uid, isAnonymous: authModel.isAnonymous, dateCreated: Date(), email: authModel.email, photoURL: authModel.photoURL)
        
        try await UserManager.shared.createNewUser(dbUser: dbUser)
//        try await UserManager.shared.createNewUser(authModel: authModel)
    }
    
} 


