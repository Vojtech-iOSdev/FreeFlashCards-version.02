//
//  PracticeVM.swift
//  FreeFlashCards
//
//  Created by Vojtěch Kalivoda on 30.04.2023.
//

import Foundation

final class PracticeVM: ObservableObject {
    
    let userManager: UserManager
    
    
    init(userManager: UserManager) {
        self.userManager = userManager
    }
    
    
    
}
