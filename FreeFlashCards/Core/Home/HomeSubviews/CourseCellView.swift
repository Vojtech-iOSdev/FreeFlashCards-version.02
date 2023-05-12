//
//  CourseCellView.swift
//  FreeFlashCards
//
//  Created by Vojtěch Kalivoda on 06.05.2023.
//

import SwiftUI

struct CourseCellView: View {
    
    @StateObject private var vm: HomeVM = .init()
    @Environment(\.dismiss) private var dismiss

    var course: Course
    
    var body: some View {
        VStack {
            name
            Spacer()
            description
            Spacer()
            startButton
        }
        .padding(30)
        .frame(width: 300, height: 600)
        .background(Color.indigo)
        .cornerRadius(40)
    }
}

struct CourseCellView_Previews: PreviewProvider {
    static var previews: some View {
        CourseCellView(course: Course(courseId: "idk", courseName: "idk", courseCompleted: true, stringArray: ["idk", "idk", "idk"]))
    }
}

private extension CourseCellView {
    var name: some View {
        Text(course.courseName)
            .bold()
            .padding()
            .background(.white)
            .cornerRadius(10)
    }
    
    var description: some View {
        Text("this is the description of the course. write like 4 line comment about what u want the user to now about the course and idk mayb eadd some picture for language/country")
    }
    
    var startButton: some View {
        Button {
            Task {
                do {
                    try await vm.updateCurrentCourseName(currentCourseName: course.courseName)
                    try await vm.updateCurrentCourseId(currentCourseId: course.courseId)
                    try await vm.createPersonalCourseForUser()
                    try await vm.copyLessonsForStartedCourse()
                    try await vm.getUser()
                    dismiss()
                } catch  {
                    print("DEBUG: could not start a course: \(error)")
                }
            }
        } label: {
            Text("Start")
        }
        .buttonStyle(.customButtonStyle01)
    }
    
}
