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
                    VStack {
                        Text("Loading")
                        ProgressView()
                    }
                    .foregroundColor(Color("AccentColor"))
                }
            }
            .padding()
        }
        .task {
            await vm.getCourses()
        }
        .alert("Try again", isPresented: $vm.retryLoadingData, actions: {
            Button {
                Task {
                   await vm.getCourses()
                    vm.retryLoadingData = false
                }
            } label: {
                Text("Retry")
            }

        })
        .overlay(alignment: .topLeading) {
            Image(systemName: "xmark.circle")
                .onTapGesture {
                    dismiss()
                }
                .font(.largeTitle)
                .padding(.horizontal, 26)
                .foregroundColor(Color("AccentColor"))
        }
    }
}

struct CoursesView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesView()
    }
}
