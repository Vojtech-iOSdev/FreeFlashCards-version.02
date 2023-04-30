//
//  SettingsVM.swift
//  FreeFlashCards
//
//  Created by Vojtěch Kalivoda on 21.04.2023.
//

import Foundation

final class SettingsVM: ObservableObject {
    
    @Published var authProviders: [AuthProviderOption] = []
    @Published var authUser: AuthDataResultModel? = nil
    
    @Published var linkEmail: String = ""
    @Published var linkPassword: String = ""

    func linkGoogleAccount() async throws {
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        self.authUser = try await AuthenticationManager.shared.linkGoogle(tokens: tokens)
    }
    
    func linkAppleAccount() async throws {
        let helper = await SignInAppleHelper()
        let tokens = try await helper.startSignInWithAppleFlow()
        self.authUser = try await AuthenticationManager.shared.linkApple(tokens: tokens)
    }
    
    func linkEmailAccount() async throws {
        self.authUser = try await AuthenticationManager.shared.linkEmail(email: linkEmail, password: linkPassword)
    }
    
    func loadAuthProviders() {
        if let providers = try? AuthenticationManager.shared.getProviders() {
            authProviders = providers
        }
    }
    
    func loadAuthUser() {
        authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
    }
    
    func signOut() throws {
        try AuthenticationManager.shared.signOut()
    }
    
    func deleteAccount() async throws {
        try await AuthenticationManager.shared.deleteAccount()
        // + also must delete account from firestore (using the userID)
    }
    
    func resetPassword() async throws {
        let authUser = try AuthenticationManager.shared.getAuthenticatedUser()
        
        guard let email = authUser.email else {
            throw URLError(.badServerResponse)
        }
        
        try await AuthenticationManager.shared.resetPassword(email: email)
    }
    
    func updateEmail(newEmail: String) async throws {
        try await AuthenticationManager.shared.updateEmail(email: newEmail)
    }
    
}
