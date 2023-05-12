//
//  ProfileScreen.swift
//  FreeFlashCards
//
//  Created by Vojtěch Kalivoda on 24.04.2023.
//

import SwiftUI

struct ProfileScreen: View {
    
    @StateObject private var vm: ProfileVM = .init()
        
    let preferenceOptions = ["Sports", "Movies", "Books"]
    
    private func preferenceSelected(text: String) -> Bool {
        vm.userInfo?.preferences?.contains(text) == true
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Background()
                
                VStack {
                    List {
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
                    
                    .task {
                        try? await vm.loadCurrentUserInfo()
                    }
                }
                .navigationTitle("My Profile")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink {
                            SettingsView()
                        } label: {
                            Image(systemName: "gear")
                                .font(.headline)
                        }

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
