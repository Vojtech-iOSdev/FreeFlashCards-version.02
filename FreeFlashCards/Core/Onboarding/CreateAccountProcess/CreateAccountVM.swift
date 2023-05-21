//
//  CreateAccountVM.swift
//  FreeFlashCards
//
//  Created by Vojtěch Kalivoda on 5/13/23.
//

import Foundation

extension OnboardingVM {
    
    // MARK: SIGN UP METHODS
    func signUpGoogle() async throws {
        let authUser = try await authManager.signInWithGoogle()
        try await checkIfAccountAlreadyExists(userId: authUser.uid, authUser: authUser)
    }
    
    func signUpApple() async throws {
        let authUser = try await authManager.signInWithApple()
        try await checkIfAccountAlreadyExists(userId: authUser.uid, authUser: authUser)
    }
    
    func signUpFacebook() async throws {
        let authUser = try await authManager.signInWithFacebook()
        try await checkIfAccountAlreadyExists(userId: authUser.uid, authUser: authUser)
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
    
    
    
    // MARK: ONBOARDING INPUTS
    private func getUserId() throws -> String {
        let user = try authManager.getAuthenticatedUser()
        return user.uid
    }
    
    func updateCurrentCourseName() async throws {
        guard let courseName = selectedLanguage?.currentCourseName else { return }
        let userId = try getUserId()
        
        try await userManager.updateCurrentCourseName(userId: userId, currentCourseName: courseName)
    }
    
    func updateCurrentCourseId() async throws {
        guard let courseId = selectedLanguage?.currentCourseId else { return }
        let userId = try getUserId()
        
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
        guard let selectedDailyGoal else { return }
        let userId = try getUserId()
        
        print(userId)
        print(selectedDailyGoal)
        try await userManager.setCurrentDailyGoal(userId: userId, selectedDailyGoal: selectedDailyGoal)
    }
    
    func updateOnboardingCompleted(onboardingCompleted: Bool) async throws {
        guard let selectedDailyGoal else { return }
        let userId = try getUserId()
        
        print(userId)
        print(selectedDailyGoal)
        try await userManager.updateOnboardingCompleted(userId: userId, onboardingCompleted: onboardingCompleted)

    }
}
