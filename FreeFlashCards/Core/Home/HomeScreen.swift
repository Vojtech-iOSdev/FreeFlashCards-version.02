//
//  HomeScreen.swift
//  FreeFlashCards
//
//  Created by Vojtěch Kalivoda on 21.04.2023.
//

import SwiftUI

struct HomeScreen: View {
        
    @StateObject private var vm: HomeVM = .init()
    
    var body: some View {
        ZStack {
            Background()
            
            VStack {
                if let lessons = vm.lessons, !lessons.isEmpty {
                    ForEach(lessons) { lesson in
                        Button {
                            // start lesson 1
                        } label: {
                            NavigationLink {
                                // show LessonView
                                Text("Lekce 1")
                            } label: {
                                Text(lesson.name ?? "no name found")
                            }
                            .buttonStyle(.customButtonStyle01)
                        }
                    }
                } else {
                    Text("Dont have any lessons for u :/")
                }
            }
            .padding()
            .fullScreenCover(isPresented: $vm.showCourses) {
                CoursesView()
            }
            
        }
        .onAppear {
            Task {
                do {
                    print("DEBUG: on appear called!!")
                    try await vm.getUser()
//                    try await vm.getLessonsForStartedCourse()
                } catch {
                    print("DEBUG: getUser func error or lessons func error: \(error)")
                }
            }
        }
        .onChange(of: vm.dbUser, perform: { newValue in
            Task {
                do {
                    try await vm.getLessonsForStartedCourse()
                } catch {
                    print("DEBUG: loading lessonssssss \(error)")
                }

            }
        })
        .overlay(alignment: .top) {
            VStack {
                Button {
                    vm.showCourses = true
                } label: {
                    Text("courses")
                    
                }
                .font(.title)
                .buttonStyle(.borderedProminent)
                .tint(Color("AccentColor"))
                .foregroundColor(Color("darkerColor"))
                .padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HomeScreen()
        }
    }
}
