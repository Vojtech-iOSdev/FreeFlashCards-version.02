//
//  SettingsView.swift
//  FreeFlashCards
//
//  Created by Vojtěch Kalivoda on 21.04.2023.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject private var sharedVM: SharedVM = .init()
    @StateObject private var vm: SettingsVM = .init()
    
    var body: some View {
        ZStack {
            Color.mint.ignoresSafeArea()
            
            VStack {                
                signOutButton
                
                // u must re.authenticate before deleting an account!!!!!
                deleteAccountButton
                
                if vm.authProviders.contains(.email) {
                    // create email buttons... update email, reset and update password
                }
                
                if vm.authUser?.isAnonymous == true {
                    anonymousSection
                }
                
            }
            .padding()
        }
        .onAppear {
            vm.loadAuthProviders()
            vm.loadAuthUser()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

private extension SettingsView {
    
    var signOutButton: some View {
        
        Button {
            Task {
                do {
                    try vm.signOut()
                    sharedVM.onboardingProcessCompleted = false
                } catch {
                    print(error.localizedDescription)
                }
            }
        } label: {
            Text("Sign Out")
        }
        .buttonStyle(.customButtonStyle01)
    }
    
    var deleteAccountButton: some View {
        
        Button(role: .destructive) {
            Task {
                do {
                    try await vm.deleteAccount()
                    sharedVM.onboardingProcessCompleted = false
                } catch {
                    print(error.localizedDescription)
                }
            }
        } label: {
            Text("Delete Account")
        }
        .buttonStyle(.customButtonStyle01)
    }
    
    var anonymousSection: some View {
        Section {
            Button("Link Apple Account") {
                Task {
                    do {
                        try await vm.linkAppleAccount()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }

            Button("Link Google Account") {
                Task {
                    do {
                        try await vm.linkGoogleAccount()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }

            Button("Link Email Account") {
                Task {
                    do {
                        try await vm.linkEmailAccount()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        } header: {
            Text("Create Account")
        }

    }
    
}
