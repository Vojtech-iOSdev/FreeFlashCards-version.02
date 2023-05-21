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

    @Published var error: OnboardingError?
    @Published var hasOnboardingError: Bool = false
    @Published var startOnboarding: Bool = false
    @Published var isActive: Bool = false
    
    // LATER PERSIST THIS VALUE IN REALM
    @AppStorage("onboardingProcessCompleted") var onboardingProcessCompleted: Bool = false
    
    @Published private(set) var languages: [Languages] = [.english, .french, .spanish]
    @Published var selectedLanguage: Languages? = nil
    @Published private(set) var dailyGoals: [Int] = [10, 25, 50]
    @Published var selectedDailyGoal: Int? = nil

     
    // MARK: SIGN IN METHODS
    func signInGoogle() async throws {
        let authUser = try await authManager.signInWithGoogle()
        try await checkIfAccountExists(userId: authUser.uid)
    }
    
    func signInApple() async throws {
        let authUser = try await authManager.signInWithApple()
        try await checkIfAccountExists(userId: authUser.uid)
    }
    
    func signInFacebook() async throws {
        let authUser = try await authManager.signInWithFacebook()
        try await checkIfAccountExists(userId: authUser.uid)
    }
    
    // this is not ViewLogic therefore it should be in the authManager and then here the sign-in methods should just catch any errors to inform the users using alerts or any other ViewLogic
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

    
    // MARK: ANONYMOUSLY
    func signInAnonymously() async throws {
        let authModel = try await authManager.signInAnonymously()
        let dbUser = DBUser(auth: authModel)
        try await userManager.createNewUser(dbUser: dbUser)
    }
    
    
} 
