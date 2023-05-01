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
    
    @StateObject private var sharedVM: SharedVM = .init()
    @StateObject private var vm: OnboardingVM = .init()
    
    var body: some View {
        ZStack {
            Color.pink.ignoresSafeArea()
            
            VStack {
                
                
                googleSignInButton
                
                appleSignInButton
            }
            .padding()
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
                    sharedVM.onboardingProcessCompleted = true
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        .cornerRadius(10)
    }
    
    var appleSignInButton: some View {
        
        Button {
            Task {
                do {
                    try await vm.signInApple()
                    sharedVM.onboardingProcessCompleted = true
                } catch {
                    print(error.localizedDescription)
                }
            }
        } label: {
            SignInWithAppleButtonViewRepresentable(type: .signIn, style: .white)
                .allowsHitTesting(false)
        }
        .frame(height: 55)
    }
    
}
