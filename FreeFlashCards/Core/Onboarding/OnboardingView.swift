//
//  OnboardingView.swift
//  FreeFlashCards
//
//  Created by Vojtěch Kalivoda on 22.04.2023.
//

import SwiftUI

struct OnboardingView: View {
    
    @StateObject private var routerManager: NavigationRouter = .init()
    @StateObject private var vm: OnboardingVM = .init()
    
    var body: some View {
        NavigationStack(path: $routerManager.routes) {
            ZStack {
                Background()
                
                VStack(spacing: 70) {
                    greeting
                    
                    perks
                    
                    buttons
                }
                .padding()
            }
            .navigationDestination(for: Route.self) { $0 }
        }
        .environmentObject(routerManager)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            OnboardingView()
        }
    }
}

private extension OnboardingView {
    
    var greeting: some View {
        Text("Welcome to FreeLingo")
            .font(.system(.title, design: .monospaced, weight: .medium))
            .foregroundColor(Color("AccentColor"))
    }
    
    var perks: some View {
        VStack(spacing: 35) {
            HStack {
                Image(systemName: "speedometer")
                    .font(.title)
                
                Text("Fast and Easy learning")
            }
            
            HStack {
                Image(systemName: "lasso.and.sparkles")
                    .font(.title)
                
                Text("Using most used words")
            }

            HStack {
                Image(systemName: "flag.2.crossed")
                    .font(.title2)
                
                Text("English, Spanish or even French")
            }
            
        }
        .multilineTextAlignment(.leading)
        .font(.system(.headline, design: .monospaced, weight: .medium))
        .foregroundColor(Color("AccentColor"))
    }
    
    var buttons: some View {
        VStack(spacing: 20) {
            Button {
                routerManager.push(to: .createAccountView)
                print(routerManager.routes)
            } label: {
                Text("Create Account")
            }
            .buttonStyle(.customButtonStyle01)

//            NavigationLink(value: Route.createAccountView) {
//                Text("Create Account")
//            }
//            .buttonStyle(.customButtonStyle01)
            
            Rectangle()
                .frame(width: 320, height: 2)
                .foregroundColor(Color("lighterColor"))
            
            Button {
                routerManager.push(to: .signInView)
                print(routerManager.routes)
            } label: {
                Text("Sign In")
            }
            .buttonStyle(.customButtonStyle01)
            
//            NavigationLink(value: Route.signInView) {
//                Text("Sign In")
//            }
//            .buttonStyle(.customButtonStyle01)
            
            Rectangle()
                .frame(width: 320, height: 2)
                .foregroundColor(Color("lighterColor"))
            
            Button {
                Task {
                    do {
                        try await vm.signInAnonymously()
                        vm.onboardingProcessCompleted = true
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            } label: {
                Text("Dont wanna create an account?")
            }
            .buttonStyle(.customButtonStyle01)
        }
    }
}

// MARK: Sign in anonymously button code
/*
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
 */
