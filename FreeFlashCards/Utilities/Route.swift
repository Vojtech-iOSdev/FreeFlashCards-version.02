//
//  Route.swift
//  FreeFlashCards
//
//  Created by Vojtěch Kalivoda on 5/13/23.
//

import SwiftUI

enum Route {
    case signInView
    case createAccountView
    case languagesView
    case dailyGoalView
    case settingsView
}

extension Route: View {
    
    var body: some View {
        switch self {
        case .signInView:
            SignInView()
        case .createAccountView:
            CreateAccountView()
        case .languagesView:
            LanguagesView()
        case .dailyGoalView:
            DailyGoalView()
        case .settingsView:
            SettingsView()
        }
    }
}
