//
//  ProfileVM.swift
//  FreeFlashCards
//
//  Created by Vojtěch Kalivoda on 24.04.2023.
//

import Foundation

@MainActor
final class ProfileVM: ObservableObject {
    
    @Injected(\.userManager) var userManager: UserManagerProtocol
    @Injected(\.authenticationManager) var authManager: AuthenticationManagerProtocol
    
    @Published private(set) var userInfo: DBUser? = nil
    
    
    func loadCurrentUserInfo() async throws {
        let authModel = try authManager.getAuthenticatedUser()
        self.userInfo = try await userManager.getUser(userID: authModel.uid)
    }
    
    func togglePremiumStatus() {
        guard let userInfo else { return }
        let currentPremiumStatus = userInfo.isPremium ?? false
        
        Task {
            do {
                try await userManager.updateUserPremiumStatus(userID: userInfo.userId,isPremium: !currentPremiumStatus)
                self.userInfo = try await userManager.getUser(userID: userInfo.userId)
            } catch {
                print("erorr1 profileview: \(error)")
            }
        }
    }
    
    func addUserPreference(text: String) {
        guard let userInfo else { return }
        
        Task {
            do {
                try await userManager.addUserPreference(userID: userInfo.userId, preference: text)
                self.userInfo = try await userManager.getUser(userID: userInfo.userId)
            } catch {
                print("erorr2 profileview: \(error)")
            }
        }
    }
    
    func removeUserPreference(text: String) {
        guard let userInfo else { return }
        
        Task {
            do {
                try await userManager.removeUserPreference(userID: userInfo.userId, preference: text)
                self.userInfo = try await userManager.getUser(userID: userInfo.userId)
            } catch {
                print("erorr3 profileview: \(error)")
            }
        }
    }
        
}
