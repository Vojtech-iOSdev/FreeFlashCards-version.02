//
//  TabBarView.swift
//  FreeFlashCards
//
//  Created by Vojtěch Kalivoda on 21.04.2023.
//

import SwiftUI

struct TabBarView: View {
    
    @StateObject private var sharedVM: SharedVM = .init()
    @StateObject private var vm: TabBarVM = .init()
    let userManager = UserManager()
    
    var body: some View {
        
        NavigationStack {
            if !sharedVM.onboardingProcessCompleted == true {
                OnboardingView(userManager: userManager)
            } else {
                CustomTabBarContainerView(selection: $vm.tabSelection) {
                    PracticeScreen(userManager: userManager)
                        .tabBarItem(tab: .practice, selection: $vm.tabSelection)

                    HomeScreen(userManager: userManager)
                        .tabBarItem(tab: .home, selection: $vm.tabSelection)
                    
                    ProfileScreen(userManager: userManager)
                        .tabBarItem(tab: .profile, selection: $vm.tabSelection)
                }
                .ignoresSafeArea(.keyboard, edges: .bottom)
            }
        }

    }
}

struct AppTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
