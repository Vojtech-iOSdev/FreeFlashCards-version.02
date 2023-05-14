//
//  SignInView.swift
//  FreeFlashCards
//
//  Created by Vojtěch Kalivoda on 22.04.2023.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct SignInView: View {
    
    @StateObject private var vm: OnboardingVM = .init()
    
    var body: some View {
        ZStack {
            Background()
            
            VStack {
                googleSignInButton
                appleSignInButton
                facebookSignInButton
            }
            .padding()
            .alert(isPresented: $vm.hasOnboardingError,
                   error: vm.error, actions: { error in
                Button {
                    vm.hasOnboardingError = false
                } label: {
                    Text(error.suggestion)
                }
            }, message: { error in
                Text(error.message)
            })
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}

private extension SignInView {
    
    var googleSignInButton: some View {
        
        GoogleSignInButton(scheme: .light, style: .wide, state: .normal) {
            Task {
                do {
                    try await vm.signInGoogle()
                } catch {
                    print("DEBUG: error signing in with Google: \(error)")
                }
            }
        }
        .cornerRadius(10)
        .frame(height: 55)

    }
    
    var appleSignInButton: some View {
        
        Button {
            Task {
                do {
                    try await vm.signInApple()
                } catch {
                    print("DEBUG: error signing in with Apple: \(error)")
                }
            }
        } label: {
            SignInWithAppleButtonViewRepresentable(type: .signIn, style: .white)
                .allowsHitTesting(false)
        }
        .frame(height: 55)
    }
    
    var facebookSignInButton: some View {
        
        Button {
            Task {
                do {
                    try await vm.signInFacebook()
                } catch {
                    print("DEBUG: error signing in with Facebook: \(error)")
                }
            }
        } label: {
            HStack {
                Image(systemName: "person.fill")
                Image(systemName: "book.fill")
                Text("Sign in with Facebook")
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .frame(height: 55)
        .background(Color.white)
        .foregroundColor(Color.blue)
        .cornerRadius(5)
        .font(.system(.title3, design: .default, weight: .medium))
    }
    
}
