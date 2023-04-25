//
//  TabBarItem.swift
//  FreeFlashCards
//
//  Created by Vojtěch Kalivoda on 21.04.2023.
//

import Foundation
import SwiftUI

enum TabBarItem: Hashable {
    case home, practice, profile
    
    var iconName: String {
        switch self {
        case .home: return "house"
        case .practice: return "dumbbell"
        case .profile: return "person"
        }
    }
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .practice: return "Practice"
        case .profile: return "Profile"
        }
    }
    
    var color: Color {
        switch self {
        case .home: return Color.red
        case .practice: return Color.blue
        case .profile: return Color.green
        }
    }
}
