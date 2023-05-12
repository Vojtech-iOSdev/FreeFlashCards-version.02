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
            Background()
            
            VStack {
                if let courses = vm.courses {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(courses) { course in
                                CourseCellView(course: course)
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
