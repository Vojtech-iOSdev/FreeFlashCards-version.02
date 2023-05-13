//
//  LanguagesView.swift
//  FreeFlashCards
//
//  Created by Vojtěch Kalivoda on 5/12/23.
//

import SwiftUI

struct LanguagesView: View {
    
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
                ForEach(vm.languages, id: \.rawValue) { language in
                    HStack {
                        Text(language.rawValue)
                        
                        Spacer()
                        
                        Image(systemName: vm.selectedLanguage == language ? "checkmark.square" : "square")
                            .animation(.default, value: vm.selectedLanguage)
                    }
                    .padding(40)
                    .frame(maxWidth: .infinity)
                    .frame(height: 90)
                    .background(Color(vm.selectedLanguage == language ? "AccentColor" : "lighterColor"))
                    .foregroundColor(Color("darkerColor"))
                    .cornerRadius(10)
                    .font(.system(.title, design: .monospaced, weight: .medium))
                    .onTapGesture {
                        vm.selectedLanguage = language
                    }
                }
            }
            .padding()
            .navigationTitle(vm.selectedLanguage != nil ? vm.selectedLanguage?.rawValue ?? "Select a language" : "Select a language")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if vm.selectedLanguage != nil {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            Task {
                                try await vm.updateCurrentCourseName()
                                try await vm.updateCurrentCourseId()
                                routerManager.push(to: .dailyGoalView)
                            }
                        } label: {
                            Image(systemName: "chevron.right")
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

struct LanguagesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            LanguagesView()
                .environmentObject(NavigationRouter())
        }
    }
}
