//
//  OnboardingVM.swift
//  FreeFlashCards
//
//  Created by Vojtěch Kalivoda on 22.04.2023.
//

import SwiftUI
import AuthenticationServices

@MainActor
final class OnboardingVM: ObservableObject {
    
    @Injected(\.userManager) var userManager: UserManagerProtocol
    @Injected(\.authenticationManager) var authManager: AuthenticationManagerProtocol
    
    @Published private(set) var error: OnboardingError?
    @Published var hasOnboardingError: Bool = false
    @Published var startOnboarding: Bool = false
    
    // LATER PERSIST THIS VALUE IN REALM
    @AppStorage("onboardingProcessCompleted") var onboardingProcessCompleted: Bool = false

    
    // MARK: SIGN IN
    func signInGoogle() async throws {
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        let authUser = try await authManager.signInWithGoogle(tokens: tokens)
        let userId = authUser.uid
        
        try await checkIfAccountExists(userId: userId)
    }
    
    func signInApple() async throws {
        let helper = SignInAppleHelper()
        let tokens = try await helper.startSignInWithAppleFlow()
        let authUser = try await authManager.signInWithApple(tokens: tokens)
        let userId = authUser.uid
        
        try await checkIfAccountExists(userId: userId)
    }
    
    private func checkIfAccountExists(userId: String) async throws {
        do {
            let _ = try await userManager.getUser(userID: userId)
            self.onboardingProcessCompleted = true
        } catch {
            try await authManager.deleteAuthorization()
            self.hasOnboardingError = true
            self.error = .accountDoesntExist
        }
    }
    
    
    // MARK: SIGN UP
    func signUpGoogle() async throws {
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        let authUser = try await authManager.signInWithGoogle(tokens: tokens)
        let userId = authUser.uid
        
        try await checkIfAccountAlreadyExists(userId: userId, authUser: authUser)
    }
    
    func signUpApple() async throws {
        let helper = SignInAppleHelper()
        let tokens = try await helper.startSignInWithAppleFlow()
        let authUser = try await authManager.signInWithApple(tokens: tokens)
        let userId = authUser.uid
        
        try await checkIfAccountAlreadyExists(userId: userId, authUser: authUser)
    }
    
    private func checkIfAccountAlreadyExists(userId: String, authUser: AuthDataResultModel) async throws {
        do {
            let user = try await userManager.getUser(userID: userId)
            
            if user.onboardingCompleted {
                self.onboardingProcessCompleted = true
            } else {
                try await authManager.deleteAccount()
                self.hasOnboardingError = true
                self.error = .somethingWentWrong
            }
        } catch {
            let dbUser = DBUser(auth: authUser)
            try await userManager.createNewUser(dbUser: dbUser)
            self.startOnboarding = true
        }
    }
    
    
    // MARK: ANONYMOUSLY
    func signInAnonymously() async throws {
        let authModel = try await authManager.signInAnonymously()
        let dbUser = DBUser(auth: authModel)
        try await userManager.createNewUser(dbUser: dbUser)
    }
} 
