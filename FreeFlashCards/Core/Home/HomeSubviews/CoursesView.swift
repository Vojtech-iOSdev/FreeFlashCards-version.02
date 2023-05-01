//
//  CoursesView.swift
//  FreeFlashCards
//
//  Created by Vojtěch Kalivoda on 28.04.2023.
//

import SwiftUI

struct CoursesView: View {
    
    @StateObject private var vm: HomeVM = .init()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color.brown.ignoresSafeArea()
            
            VStack {
                if let courses = vm.courses {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(courses) { course in
                                VStack {
                                    Text(course.courseName)
                                        .bold()
                                        .padding()
                                        .background(.white)
                                        .cornerRadius(10)
                                    
                                    Spacer()
                                    
                                    Text("this is the description of the course. write like 4 line comment about what u want the user to now about the course and idk mayb eadd some picture for language/country")
                                    
                                    Spacer()
                                    
                                    Button {
                                        // fetch by course.courseId
                                        Task {
                                            vm.testingCreatingDocs()
                                            //await vm.createPersonalCourse(courseId: course.courseId)
                                            print("success creating perso course!!!!!")
                                        }
                                        
                                        dismiss()
                                    } label: {
                                        Text("Začni Kurz")
                                    }
                                    .buttonStyle(.customButtonStyle01)
                                }
                                .padding(30)
                                .frame(width: 300, height: 700)
                                .background(Color.red)
                                .cornerRadius(40)
                            }
                        }
                    }
                } else {
                    ProgressView()
                }
                
            }
            .padding()
        }
        .task {
            await vm.getCourses()
        }
        .overlay(alignment: .topLeading) {
            Image(systemName: "xmark.circle")
                .onTapGesture {
                    dismiss()
                }
                .font(.largeTitle)
                .padding(.horizontal, 26)
        }
    }
}

struct CoursesView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesView()
    }
}
