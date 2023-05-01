//
//  PracticeVM.swift
//  FreeFlashCards
//
//  Created by Vojtěch Kalivoda on 30.04.2023.
//

import Foundation

final class PracticeVM: ObservableObject {
        
    @Injected(\.userManager) var userManager: UserManagerProtocol
    
    @Published private(set) var text: String = "noooo"
    
    func showText() {
        text = userManager.testFunc()
    }
    
    
}
