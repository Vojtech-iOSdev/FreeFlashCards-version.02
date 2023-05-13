//
//  DailyGoalView.swift
//  FreeFlashCards
//
//  Created by Vojtěch Kalivoda on 5/12/23.
//

import SwiftUI

struct DailyGoalView: View {
    
    @EnvironmentObject private var routerManager: NavigationRouter
    @StateObject private var vm: OnboardingVM = .init()
    
    // refactor this to custom modifier later
    init() {
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        ZStack {
            Background()
            
            VStack(spacing: 20) {
                ForEach(vm.dailyGoals, id: \.self) { goal in
                    HStack {
                        Text("\(goal) new words")
                        
                        Spacer()
                        
                        Image(systemName: vm.selectedDailyGoal == goal ? "checkmark.square" : "square")
                            .animation(.default, value: vm.selectedDailyGoal)
                    }
                    .padding(40)
                    .frame(maxWidth: .infinity)
                    .frame(height: 90)
                    .background(Color(vm.selectedDailyGoal == goal ? "AccentColor" : "lighterColor"))
                    .foregroundColor(Color("darkerColor"))
                    .cornerRadius(10)
                    .font(.system(.title, design: .monospaced, weight: .medium))
                    .onTapGesture {
                        vm.selectedDailyGoal = goal
                    }
                }
                
                
                Button {
                    vm.selectedDailyGoal = 11
                    Task {
                        try await vm.setCurrentDailyGoal()
                    }
                } label: {
                    Text("set daily goal to eleven")
                }
                .buttonStyle(.customButtonStyle01)
                
                
            }
            .padding()
            .navigationTitle(vm.selectedDailyGoal != nil ? "Complete Profile Creation" : "Select a Daily Goal")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if vm.selectedDailyGoal != nil {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            Task {
                                try await vm.setCurrentDailyGoal()
                            }
                            vm.startOnboarding = false
                            vm.onboardingProcessCompleted = true
                            routerManager.reset()
                        } label: {
                            Image(systemName: "chevron.right.2")
                                .padding()
                        }
                    }
                }
            }
            .foregroundColor(Color.white)
        }
        .onAppear {
            print("routess are: \(routerManager.routes)")
        }
    }
}

struct ConditionsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DailyGoalView()
                .environmentObject(NavigationRouter())
        }
    }
}
