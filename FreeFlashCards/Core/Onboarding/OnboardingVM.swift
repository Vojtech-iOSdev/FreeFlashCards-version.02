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
    
    let userManager: UserManager
    
    init(userManager: UserManager) {
        self.userManager = userManager
    }
    
    func signInGoogle() async throws {
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        let authModel = try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
        let dbUser = DBUser(auth: authModel)
        try await userManager.createNewUser(dbUser: dbUser)
    }
    
    func signInApple() async throws {
        let helper = SignInAppleHelper()
        let tokens = try await helper.startSignInWithAppleFlow()
        let authModel = try await AuthenticationManager.shared.signInWithApple(tokens: tokens)
        let dbUser = DBUser(auth: authModel)
        try await userManager.createNewUser(dbUser: dbUser)
    }
    
    func signInAnonymously() async throws {
        let authModel = try await AuthenticationManager.shared.signInAnonymously()
        let dbUser = DBUser(auth: authModel)
        try await userManager.createNewUser(dbUser: dbUser)
    }
    
} 


