//
//  SharedVM.swift
//  FreeFlashCards
//
//  Created by Vojtěch Kalivoda on 22.04.2023.
//

import SwiftUI

final class SharedVM: ObservableObject {
    
    @AppStorage("onboardingProcessCompleted") var onboardingProcessCompleted: Bool = false
    
}
