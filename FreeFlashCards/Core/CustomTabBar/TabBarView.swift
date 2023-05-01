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
    
    var body: some View {
        
        NavigationStack {
            if !sharedVM.onboardingProcessCompleted == true {
                OnboardingView()
            } else {
                CustomTabBarContainerView(selection: $vm.tabSelection) {
                    PracticeScreen()
                        .tabBarItem(tab: .practice, selection: $vm.tabSelection)

                    HomeScreen()
                        .tabBarItem(tab: .home, selection: $vm.tabSelection)
                    
                    ProfileScreen()
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
