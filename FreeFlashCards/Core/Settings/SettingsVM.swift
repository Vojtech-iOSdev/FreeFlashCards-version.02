//
//  SettingsVM.swift
//  FreeFlashCards
//
//  Created by Vojtěch Kalivoda on 21.04.2023.
//

import Foundation

final class SettingsVM: ObservableObject {
    
    @Injected(\.authenticationManager) var authManager: AuthenticationManagerProtocol
    
    @Published var authProviders: [AuthProviderOption] = []
    @Published var authUser: AuthDataResultModel? = nil
    
    @Published var linkEmail: String = ""
    @Published var linkPassword: String = ""

    func linkGoogleAccount() async throws {
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        self.authUser = try await authManager.linkGoogle(tokens: tokens)
    }
    
    func linkAppleAccount() async throws {
        let helper = await SignInAppleHelper()
        let tokens = try await helper.startSignInWithAppleFlow()
        self.authUser = try await authManager.linkApple(tokens: tokens)
    }
    
    func linkEmailAccount() async throws {
        self.authUser = try await authManager.linkEmail(email: linkEmail, password: linkPassword)
    }
    
    func loadAuthProviders() {
        if let providers = try? authManager.getProviders() {
            authProviders = providers
        }
    }
    
    func loadAuthUser() {
        authUser = try? authManager.getAuthenticatedUser()
    }
    
    func signOut() throws {
        try authManager.signOut()
    }
    
    func deleteAccount() async throws {
        try await authManager.deleteAccount()
        // + also must delete account from firestore (using the userID)
    }
    
    func resetPassword() async throws {
        let authUser = try authManager.getAuthenticatedUser()
        
        guard let email = authUser.email else {
            throw URLError(.badServerResponse)
        }
        
        try await authManager.resetPassword(email: email)
    }
    
    func updateEmail(newEmail: String) async throws {
        try await authManager.updateEmail(email: newEmail)
    }
    
}
