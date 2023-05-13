//
//  CreateAccountView.swift
//  FreeFlashCards
//
//  Created by Vojtěch Kalivoda on 22.04.2023.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct CreateAccountView: View {
    
    @EnvironmentObject private var routerManager: NavigationRouter
    @StateObject private var vm: OnboardingVM = .init()
    
    var body: some View {
        ZStack {
            Background()
            
            VStack {
                googleSignInButton
                appleSignInButton
            }
            .padding()
            .navigationDestination(isPresented: $vm.startOnboarding) {
                LanguagesView()
            }
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
        .onAppear {
            print("routess are: \(routerManager.routes)")
        }
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CreateAccountView()
                .environmentObject(NavigationRouter())
        }
    }
}

private extension CreateAccountView {
    
    var googleSignInButton: some View {
        
        GoogleSignInButton(scheme: .light, style: .wide, state: .normal) {
            Task {
                do {
                    try await vm.signUpGoogle()
                } catch {
                    print(error)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .cornerRadius(10)
        .frame(height: 55)

    }
    
    var appleSignInButton: some View {
        
        Button {
            Task {
                do {
                    try await vm.signUpApple()
                } catch {
                    print(error)
                }
            }
        } label: {
            SignInWithAppleButtonViewRepresentable(type: .signUp, style: .white)
                .allowsHitTesting(false)
        }
        .frame(height: 55)
    }
    
}
