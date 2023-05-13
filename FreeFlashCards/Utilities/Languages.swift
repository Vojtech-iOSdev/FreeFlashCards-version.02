//
//  Languages.swift
//  FreeFlashCards
//
//  Created by Vojtěch Kalivoda on 5/12/23.
//

import Foundation

enum Languages: String {
    case english = "English"
    case spanish = "Spanish"
    case french = "French"
    
    var currentCourseName: String {
        switch self {
        case .english:
            return "english_course"
        case .spanish:
            return "spanish_course"
        case .french:
            return "french_course"
        }
    }
    
    var currentCourseId: String {
        switch self {
        case .english:
            return "MSViMEEUOhmoMEUMAJQM"
        case .spanish:
            return "Wm9reghZEwtLTS2F2AKU"
        case .french:
            return "QAlAq9TfL5kGLqQMrQRy"
        }
    }
}
