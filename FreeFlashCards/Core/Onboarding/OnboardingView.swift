//
//  OnboardingView.swift
//  FreeFlashCards
//
//  Created by Vojtěch Kalivoda on 22.04.2023.
//

import SwiftUI

struct OnboardingView: View {
    
    @StateObject private var sharedVM: SharedVM = .init()
    @StateObject private var vm: OnboardingVM
    
    init(vm: OnboardingVM) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        ZStack {
            Color.pink.ignoresSafeArea()
            
            VStack(spacing: 40) {
                
                NavigationLink {
                    SignInView(vm: OnboardingVM(userManager: UserManager()))
                } label: {
                    Text("Sign In")
                }
                .buttonStyle(.customButtonStyle01)
                
                Rectangle()
                    .frame(width: 320, height: 2)
                    .foregroundColor(Color.white)
                
                NavigationLink {
                    CreateAccountView()
                } label: {
                    Text("Create an Account")
                }
                .buttonStyle(.customButtonStyle01)
                
                Rectangle()
                    .frame(width: 320, height: 2)
                    .foregroundColor(Color.white)
                
                Button {
                    Task {
                        do {
                            try await vm.signInAnonymously()
                            sharedVM.onboardingProcessCompleted = true
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                } label: {
                    Text("Dont wanna create an account?")
                }
                .buttonStyle(.customButtonStyle01)
            }
            .padding()
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(vm: OnboardingVM(userManager: UserManager()))
    }
}
