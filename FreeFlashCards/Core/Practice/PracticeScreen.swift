//
//  PracticeScreen.swift
//  FreeFlashCards
//
//  Created by Vojtěch Kalivoda on 21.04.2023.
//

import SwiftUI

struct PracticeScreen: View {
    
    @StateObject private var vm: PracticeVM = .init()
        
    var body: some View {
        ZStack {
            Background()
            
            ScrollView {
                VStack(spacing: 20) {
                    Text("text: \(vm.text)")
                    
                    Button("call func") {
                        vm.showText()
                    }
                    .padding()
                    .background(.blue)
                    .cornerRadius(15)
                    .buttonStyle(.customButtonStyle01)
                                
                    if  let courses = vm.courses,
                        let queryCourses = vm.specificCourse,
                        let lessons = vm.lessons
                    {
                        List(courses) {
                            Text($0.courseName)
                            Text($0.courseId)
                            Text($0.courseCompleted?.description ?? "no value")
                            Text($0.stringArray?.joined(separator: " ") ?? "no value")
                            Text("")
                        }
                        
                        ForEach(courses) { course in
                            Text(course.stringArray?.joined(separator: " ") ?? "no value")
                        }
                        
                        Text(queryCourses.first?.courseName ?? "no value")
                        
                        ForEach(lessons) { lesson in
                            VStack {
                                Text("getting subCol docs: \(lesson.name ?? "i am idiot")")
                            }
                        }
                        
                        Button("create doc in sub colecion") {
                            // create a doc in subColection
                        }
                        .padding()
                        .background(.blue)
                        .cornerRadius(15)
                        .buttonStyle(.customButtonStyle01)
                    }
                }
                .padding()
                .task {
                    do {
                        try await vm.getCourses()
                        try await vm.getSingleCourseByName()
                        try await vm.getSubCollectionDocs()
                    } catch {
                        debugPrint(error)
                        print("error calling some of the funcs XD \(error)")
                    }
                }
            }
        }
    }
}

struct PracticeScreen_Previews: PreviewProvider {
    static var previews: some View {
        PracticeScreen()
    }
}
