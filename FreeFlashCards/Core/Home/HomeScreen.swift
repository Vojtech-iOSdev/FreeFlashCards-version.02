//
//  HomeScreen.swift
//  FreeFlashCards
//
//  Created by Vojtěch Kalivoda on 21.04.2023.
//

import SwiftUI

struct HomeScreen: View {
        
    @StateObject private var vm: HomeVM
    
    init(userManager: UserManager) {
        _vm = StateObject(wrappedValue: HomeVM(userManager: userManager))
    }
    
    var body: some View {
        ZStack {
            Color.pink.ignoresSafeArea()
            
            VStack {
                Button {
                    // start lesson 1
                } label: {
                    NavigationLink {
                        // show LessonView
                        Text("Lekce 1")
                    } label: {
                        Text("Lekce 1")
                    }
                    .buttonStyle(.customButtonStyle01)
                }
                
                Button {
                    // start "Lekce 2"
                } label: {
                    NavigationLink {
                        // show LessonView
                        Text("Lekce 2")
                    } label: {
                        Text("Lekce 2")
                    }
                    .buttonStyle(.customButtonStyle01)
                }
            }
            .padding()
            .fullScreenCover(isPresented: $vm.showCourses) {
                CoursesView(userManager: UserManager())
            }
        }
        .overlay(alignment: .top) {
            Button {
                vm.showCourses = true
            } label: {
                Text("courses")
                
            }
            .font(.title)
            .buttonStyle(.borderedProminent)
            .tint(.white)
            .foregroundColor(.red)
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HomeScreen(userManager: UserManager())
        }
    }
}
