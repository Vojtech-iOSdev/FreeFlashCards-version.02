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
    @Published var isActive: Bool = false
    
    // LATER PERSIST THIS VALUE IN REALM
    @AppStorage("onboardingProcessCompleted") var onboardingProcessCompleted: Bool = false
    
    @Published private(set) var languages: [Languages] = [.english, .french, .spanish]
    @Published var selectedLanguage: Languages? = nil
    @Published private(set) var dailyGoals: [Int] = [10, 25, 50]
    @Published var selectedDailyGoal: Int? = nil
    @Published private var currentUser: AuthDataResultModel? = nil

    
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
        self.currentUser = try await authManager.signInWithGoogle(tokens: tokens)
        guard let currentUser else { return }
        
        try await checkIfAccountAlreadyExists(userId: currentUser.uid, authUser: currentUser)
    }
    
    func signUpApple() async throws {
        let helper = SignInAppleHelper()
        let tokens = try await helper.startSignInWithAppleFlow()
        self.currentUser = try await authManager.signInWithApple(tokens: tokens)
        guard let currentUser else { return }
        
        try await checkIfAccountAlreadyExists(userId: currentUser.uid, authUser: currentUser)
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
    
    // MARK: ONBOARDING INPUTS
    func updateCurrentCourseName() async throws {
        guard let userId = currentUser?.uid else { return }
        guard let courseName = selectedLanguage?.currentCourseName else { return }
        
        try await userManager.updateCurrentCourseName(userId: userId, currentCourseName: courseName)
    }
    
    func updateCurrentCourseId() async throws {
        guard let userId = currentUser?.uid else { return }
        guard let courseId = selectedLanguage?.currentCourseId else { return }
        
        try await userManager.updateCurrentCourseId(userId: userId, currentCourseId: courseId)
    }
    
//    func updateEnableNotifications() async throws {
//        guard let userId = currentUser?.uid else { return }
//        guard let dailyGoal = selectedDailyGoal else { return }
//
//        try await userManager.updateCurrentDailyGoal(userId: userId, selectedDailyGoal: dailyGoal)
//
//    }
    
    func setCurrentDailyGoal() async throws {
        guard let userId = currentUser?.uid else { return }
        guard let selectedDailyGoal else { return }
        
        try await userManager.setCurrentDailyGoal(userId: userId, selectedDailyGoal: selectedDailyGoal)
    }
    
    
} 
