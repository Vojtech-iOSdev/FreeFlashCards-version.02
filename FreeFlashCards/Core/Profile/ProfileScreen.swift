//
//  ProfileScreen.swift
//  FreeFlashCards
//
//  Created by Vojtěch Kalivoda on 24.04.2023.
//

import SwiftUI

struct ProfileScreen: View {
    
    @StateObject private var routerManager: NavigationRouter = .init()
    @StateObject private var vm: ProfileVM = .init()
    
    let preferenceOptions = ["Sports", "Movies", "Books"]
    
    private func preferenceSelected(text: String) -> Bool {
        vm.userInfo?.preferences?.contains(text) == true
    }
    
    var body: some View {
        NavigationStack(path: $routerManager.routes) {
            ZStack {
                Background()
                
                VStack {
                    if let user = vm.userInfo {
                        Text("userID: \(user.userId)")
                        
                        if let isAnonymous = user.isAnonymous {
                            Text("isAnonymous: \(isAnonymous.description)")
                        }
                        
                        Button("Is premium: \((user.isPremium ?? false).description)") {
                            vm.togglePremiumStatus()
                        }
                        .buttonStyle(.customButtonStyle01)
                        
                        HStack {
                            ForEach(preferenceOptions, id: \.self) { text in
                                Button(text) {
                                    if preferenceSelected(text: text) {
                                        vm.removeUserPreference(text: text)
                                    } else {
                                        vm.addUserPreference(text: text)
                                    }
                                }
                                .buttonStyle(.borderedProminent)
                                .tint(preferenceSelected(text: text) ? .green : .red)
                            }
                        }
                        
                        Text("user preferences: \((user.preferences ?? []).joined(separator: ", "))")
                    }
                }
                .navigationTitle("My Profile")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            routerManager.push(to: .settingsView)
                            print(routerManager.routes)
                        } label: {
                            Image(systemName: "gear")
                                .font(.headline)
                        }
                        
                    }
                }
                .navigationDestination(for: Route.self) { $0 }
                .task {
                    do {
                        try await vm.loadCurrentUserInfo()
                    } catch {
                        print("DEBUG: profile view error: \(error)")
                    }
                }
            }
        }
    }
}

struct ProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProfileScreen()
    }
}
