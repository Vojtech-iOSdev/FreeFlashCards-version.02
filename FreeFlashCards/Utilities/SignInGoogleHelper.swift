//
//  SignInGoogleHelper.swift
//  FreeFlashCards
//
//  Created by Vojtěch Kalivoda on 22.04.2023.
//

import Foundation
import GoogleSignIn
import GoogleSignInSwift


struct googleSignInResultModel {
    let idToken: String
    let accessToken: String
    let email: String?
    let name: String?
}

final class SignInGoogleHelper {
    
    @MainActor
    func signIn() async throws -> googleSignInResultModel {
        
        //... need to find the TopUIViewController in order for this to be reusable!!! ...//
        guard let topVC = Utilities.shared.topViewController() else {
            throw URLError(.badServerResponse)
        }
        
        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        
        let accessToken = gidSignInResult.user.accessToken.tokenString
        guard let idToken = gidSignInResult.user.idToken?.tokenString else {
            throw URLError(.badServerResponse)
        }
        let email = gidSignInResult.user.profile?.email
        let name = gidSignInResult.user.profile?.givenName
        
        let tokens = googleSignInResultModel(idToken: idToken, accessToken: accessToken, email: email, name: name)
        
        return tokens
    }

}
