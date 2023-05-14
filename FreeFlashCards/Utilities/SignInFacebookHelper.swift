//
//  SignInFacebookHelper.swift
//  FreeFlashCards
//
//  Created by Vojtěch Kalivoda on 5/14/23.
//

import Foundation
import FacebookLogin

struct FacebookSignInResultModel {
    let token: String
//    let name: String?
//    let email: String?
}

@MainActor
final class SignInFacebookHelper {
    
    let loginManager = LoginManager()
    
    
    func signInFacebook() async throws -> FacebookSignInResultModel {
        try await withCheckedThrowingContinuation { continuation in
            self.loginFacebook { result in
                switch result {
                case .success(let signInFacebookResult):
                    continuation.resume(returning: signInFacebookResult)
                    return
                case .failure(let error):
                    continuation.resume(throwing: error)
                    return
                }
            }
        }
    }
    
    private func loginFacebook(completionBlock: @escaping (Result<FacebookSignInResultModel, Error>) -> Void ) {
        loginManager.logIn(permissions: ["public_profile"],
                           from: nil) { loginManagerLoginResult, error in
            if let error {
                print("DEBUG: error login with FB: \(error.localizedDescription)")
                completionBlock(.failure(error))
                return
            }
            
            let token = loginManagerLoginResult?.token?.tokenString
            print("FB token: \(String(describing: token))")
            let signFacebookResultModel = FacebookSignInResultModel(token: token ?? "Empty Tokenn")
            
            completionBlock(.success(signFacebookResultModel))
        }
    }
}
