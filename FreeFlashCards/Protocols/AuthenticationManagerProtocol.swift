//
//  AuthenticationManagerProtocol.swift
//  FreeFlashCards
//
//  Created by Vojtěch Kalivoda on 01.05.2023.
//

import Foundation
import FirebaseAuth

protocol AuthenticationManagerProtocol {
    func signOut() throws
    func getAuthenticatedUser() throws -> AuthDataResultModel
    func getProviders() throws -> [AuthProviderOption]
    func createUser(email: String, password: String) async throws -> AuthDataResultModel
    func signInUser(email: String, password: String) async throws -> AuthDataResultModel
    func resetPassword(email: String) async throws
    func updatePassword(password: String) async throws
    func updateEmail(email: String) async throws
    func signInWithGoogle(tokens: GoogleSignInResultModel) async throws -> AuthDataResultModel
    func signInWithApple(tokens: SignInWithAppleResult) async throws -> AuthDataResultModel
    func signInWithFacebook(token: FacebookSignInResultModel) async throws -> AuthDataResultModel
    func signIn(credential: AuthCredential) async throws -> AuthDataResultModel
    func deleteAccount() async throws
    func deleteAuthorization() async throws
    func signInAnonymously() async throws -> AuthDataResultModel
    func linkEmail(email: String, password: String) async throws -> AuthDataResultModel
    func linkApple(tokens: SignInWithAppleResult) async throws -> AuthDataResultModel
    func linkGoogle(tokens: GoogleSignInResultModel) async throws -> AuthDataResultModel
    
}
