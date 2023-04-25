//
//  ProfileScreen.swift
//  FreeFlashCards
//
//  Created by Vojtěch Kalivoda on 24.04.2023.
//

import SwiftUI

struct ProfileScreen: View {
    
    @StateObject private var vm: ProfileVM = .init()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.green.ignoresSafeArea()
                
                List {
                    if let user = vm.userInfo {
                        Text("userID: \(user.userID)")
                        
                        if let isAnonymous = user.isAnonymous {
                            Text("isAnonymous: \(isAnonymous.description)")
                        }
                        
                    }
                }
                .task {
                    try? await vm.loadCurrentUserInfo()
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
